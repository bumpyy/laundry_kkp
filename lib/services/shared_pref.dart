import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get username => _sharedPrefs.getString(keyUsername) ?? "";

  set username(String value) {
    _sharedPrefs.setString(keyUsername, value);
  }

  String get email => _sharedPrefs.getString(keyEmail) ?? "";

  set email(String value) {
    _sharedPrefs.setString(keyEmail, value);
  }
}

final sharedPrefs = SharedPrefs();
// constants/strings.dart
const String keyUsername = "key_username";
const String keyEmail = "key_email";
