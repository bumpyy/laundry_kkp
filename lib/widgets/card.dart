import 'package:flutter/material.dart';
import 'package:laundry_kkp/model/laundry.dart';

class Card extends StatelessWidget {
  final List<Laundry> laundryList;

  Card(this.laundryList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: laundryList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(''),
            ],
          ),
        );
      },
    );
  }
}
