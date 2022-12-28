import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qtasnim_flutter/screen/transaksi/transaksi_add.dart';
import 'package:qtasnim_flutter/services/services.dart';
// import 'package:qtasnim_flutter/services/services.dart';
import 'screen/transaksi/transaksi_provider.dart';
import 'screen/transaksi/transaksi_bloc.dart';
import 'screen/transaksi/transaksi.dart';
import 'dt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      // home: TransaksiAdd(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _searchTransaksi({String nama_barang = '', String order = ''}) {
    transaksiBloc.updateTransaksi(nama_barang: nama_barang, order: order);
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 2), (timer) async {
      _searchTransaksi(nama_barang: '');
      
      timer.cancel();
    });
  }

  String _cariTransaksi = '';
  String _orderBy = 'nama_barang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F3F5),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Cari Transaksi",
                  ),
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    _cariTransaksi = value;
                    _searchTransaksi(nama_barang: value);
                  },
                  onFieldSubmitted: (value) {
                    _searchTransaksi(nama_barang: value);
                  },
                ),
                Text("Order By"),
                SizedBox(
                  width: 300,
                  child: DropdownButton(
                    value: _orderBy,
                    onChanged: (value) {
                      setState(() {
                        _orderBy = value.toString();

                        _searchTransaksi(
                            nama_barang: _cariTransaksi,
                            order: value.toString());
                      });

                      print(_orderBy);
                    },
                    items: [
                      DropdownMenuItem(
                        value: "nama_barang",
                        child: Text("Barang"),
                      ),
                      DropdownMenuItem(
                        value: "tgl_transaksi",
                        child: Text("Tanggal"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 700,
                  child: Transaksi(),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton.icon(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Tambah Transaksi',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TransaksiAdd(),));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
