import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import '../model/laundry.dart';

class DetailPesanan extends StatelessWidget {
  final Laundry laundry;

  DetailPesanan(this.laundry);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail pemesanan ${laundry.nama}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColoredBox(
            color: Colors.lightGreen,
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(laundry.nama),
                              Text(laundry.id.toString()),
                              Text(laundry.date),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                width: 2.0,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(laundry.kategoriPengerjaan),
                              Text(laundry.kategori),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            rupiah(laundry.harga.toString(), trailing: ',-'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    Text('Status Pembayaran'),
                    Text(laundry.sudahBayar == 0
                        ? "BELUM DIBAYARKAN"
                        : "SUDAH DIBAYARKAN"),
                  ],
                ),
                Column(
                  children: [
                    Text('Status Pengerjaan'),
                    Text(laundry.statusPengerjaan),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
