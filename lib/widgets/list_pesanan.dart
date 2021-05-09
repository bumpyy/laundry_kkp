import 'package:flutter/material.dart';
import 'package:laundry_kkp/screenAdmin/detailPesananAdmin.dart';
import '../model/laundry.dart';
import '../screenUser/detailPesanan.dart';
import '../services/db_helper.dart';
import '../services/shared_pref.dart';

class ListPesanan extends StatefulWidget {
  ListPesanan({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _ListPesananState createState() => new _ListPesananState();
}

class _ListPesananState extends State<ListPesanan> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(
          "Daftar Pesanan anda",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: SharedPrefs().username == 'admin@admin.com'
            ? DatabaseHelper.instance.queryAllPesananRows()
            : DatabaseHelper.instance
                .queryAllPesananSingleUserRows(SharedPrefs().username),
        initialData: [],
        builder: (context, snapshot) {
          // print(snapshot.data);
          return Container(
            height: MediaQuery.of(context).size.height,
            child: snapshot.data.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.local_laundry_service),
                        Text('Belum ada pesanan')
                      ],
                    ),
                  )
                : Scrollbar(
                    thickness: 10,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0.0),
                      scrollDirection: Axis.vertical,
                      primary: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext content, int index) {
                        return GestureDetector(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    SharedPrefs().username == 'admin@admin.com'
                                        ? DetailPesananAdmin(
                                            new Laundry.fromJson(
                                              snapshot.data[index],
                                            ),
                                          )
                                        : DetailPesanan(
                                            new Laundry.fromJson(
                                              snapshot.data[index],
                                            ),
                                          ),
                              ),
                            )
                          },
                          child: AwesomeListItem(
                            title: snapshot.data[index]['nama'],
                            content: snapshot.data[index]['statusPengerjaan'],
                            color: snapshot.data[index]['sudahBayar'] == 0
                                ? Colors.red
                                : Colors.green,
                            sudahBayar: snapshot.data[index]['sudahBayar'],
                          ),
                        );
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class AwesomeListItem extends StatefulWidget {
  final String title;
  final String content;
  final Color color;
  final int sudahBayar;

  AwesomeListItem({this.title, this.content, this.color, this.sudahBayar});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ColoredBox(
        color: Colors.lightGreen[200],
        child: new Row(
          children: <Widget>[
            new Container(width: 10.0, height: 120.0, color: widget.color),
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: new Text(
                        widget.content,
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
