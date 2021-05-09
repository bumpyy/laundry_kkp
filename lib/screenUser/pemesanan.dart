import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../services/db_helper.dart';
import '../services/shared_pref.dart';

class Pemesanan extends StatefulWidget {
  @override
  _PemesananState createState() => _PemesananState();
}

class _PemesananState extends State<Pemesanan> {
  final _formKey = GlobalKey<FormBuilderState>();
  final kategoriMap = {
    'cuci': 10000,
    'setrika': 12000,
    'complete': 20000,
  };
  final kategoriPengerjaanMap = {
    'reguler': 10000,
    'express': 20000,
    'kilat': 30000,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pemesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    name: 'nama', initialValue: SharedPrefs().username,
                    decoration: InputDecoration(
                      labelText: 'Masukan Nama Anda',
                    ),
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    keyboardType: TextInputType.name,
                  ),
                  FormBuilderTextField(
                    name: 'lokasi',
                    decoration: InputDecoration(
                      icon: Icon(Icons.arrow_forward_ios),
                      labelText: 'Lokasi',
                    ),
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    keyboardType: TextInputType.streetAddress,
                  ),
                  FormBuilderDropdown(
                    name: 'kategori',
                    decoration: InputDecoration(
                      icon: Icon(Icons.arrow_forward_ios),
                      labelText: 'Kategori',
                    ),
                    initialValue: 'cuci',
                    // allowClear: true,
                    hint: Text('Kategori'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: kategoriMap.keys
                        .map((v) => DropdownMenuItem(
                              value: v,
                              child: Text('$v'),
                            ))
                        .toList(),
                  ),
                  FormBuilderTextField(
                    name: 'berat',
                    decoration: InputDecoration(
                      icon: Icon(Icons.arrow_forward_ios),
                      labelText: 'Berat',
                    ),
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.max(context, 20),
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderDropdown(
                    name: 'kategoriPengerjaan',
                    decoration: InputDecoration(
                      icon: Icon(Icons.arrow_forward_ios),
                      labelText: 'Kategori Pengerjaan',
                    ),
                    initialValue: 'reguler',
                    // allowClear: true,
                    hint: Text('Pilih Jenis Pengerjaan'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: kategoriPengerjaanMap.keys
                        .map((v) => DropdownMenuItem(
                              value: v,
                              child: Text('$v'),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Pesan",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        _formKey.currentState.save();

                        if (_formKey.currentState.validate()) {
                          final beratFinal =
                              _formKey.currentState.value['berat'];
                          final faktorHarga1 = kategoriMap[
                              _formKey.currentState.value['kategori']];
                          final faktorHarga2 = kategoriPengerjaanMap[_formKey
                              .currentState.value['kategoriPengerjaan']];

                          // print(beratFinal);
                          // print(faktorHarga1);
                          // print(faktorHarga2);
                          final date = DateTime.now();
                          final value = {
                            'emailUser': SharedPrefs().username,
                            'SudahBayar': 0,
                            'statusPengerjaan': 'diproses',
                            'harga': (int.parse(beratFinal) *
                                    (faktorHarga1 + faktorHarga2))
                                .toInt(),
                            'date': "${date.day}-${date.month}-${date.year}"
                          };
                          value.addAll(_formKey.currentState.value);
                          print(value);
                          await DatabaseHelper.instance.insertPesanan(value);
                          Navigator.pop(context);
                        } else {
                          print("validation failed");
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Kembali",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _formKey.currentState.reset();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
