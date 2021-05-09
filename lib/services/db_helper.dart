import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "databaseLaundry.db";
  static final _databaseVersion = 1;

  static final userTable = 'users';
  static final adminTable = 'admin';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db
        .execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY autoincrement,
            username TEXT NOT NULL,
            email TEXT NOT NULL,
            pass TEXT NOT NULL
          )
          ''')
        .then(
          (_) => db.execute('''
          CREATE TABLE pesanan (
            id INTEGER PRIMARY KEY autoincrement,
            nama TEXT NOT NULL,
            emailUser TEXT NOT NULL,
            lokasi TEXT NOT NULL,
            berat INTEGER NOT NULL,
            kategori TEXT NOT NULL,
            kategoriPengerjaan TEXT NOT NULL,
            harga INTEGER NOT NULL,
            date TEXT NOT NULL,
            sudahBayar INTEGER,
            statusPengerjaan TEXT NOT NULL
          )
          '''),
        )
          .then(
          (value) => db.execute('''
           CREATE TABLE admin (
            email TEXT NOT NULL,
            pass TEXT NOT NULL
          )
          '''),
        )
        .then(
          (_) => db.insert(
            'admin',
            {'email': "admin@admin", 'pass': 'admin123'},
          ),
        );
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(userTable, row);
  }

  Future<int> insertPesanan(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('pesanan', row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllUserRows() async {
    Database db = await instance.database;
    return await db.query(userTable);
  }

  Future<List<Map<String, dynamic>>> queryAllPesananRows() async {
    Database db = await instance.database;
    return await db.query('pesanan');
  }

  Future<List<Map<String, dynamic>>> queryAllPesananSingleUserRows(
      String userMail) async {
    Database db = await instance.database;
    return await db
        .rawQuery("SELECT * FROM pesanan WHERE emailUser = '$userMail'");
  }

  Future<List<dynamic>> querySingleUser(
      {String table, dynamic id, List<String> columnsToSelect}) async {
    // get a reference to the database
    Database db = await DatabaseHelper.instance.database;

    // get single row
    String whereString = 'email = ?';
    String rowId = id;
    List<dynamic> whereArguments = [rowId];
    List<Map> result = await db.query(table,
        columns: columnsToSelect,
        where: whereString,
        whereArgs: whereArguments);

    // print the results
    return result;
    // {_id: 1, email: example@mail.com, pass: example}
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String tableName) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update(userTable, row, where: 'id = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(userTable, where: 'id = ?', whereArgs: [id]);
  }
}
