import 'package:flutter/material.dart';
import 'package:qtasnim_flutter/screen/transaksi/transaksi_provider.dart';
import 'transaksi_bloc.dart';

class Transaksi extends StatefulWidget {
  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  @override
  // void dispose() {
  //   transaksiBloc.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: transaksiBloc.getTransaksi,
      initialData: TransaksiProvider().transaksi,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(20),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${snapshot.data?[index]['tgl_transaksi']}",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "${snapshot.data?[index]['nama_barang']}",
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Stok: ${snapshot.data?[index]['stok_awal']}",
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Jumlah Terjual: ${snapshot.data?[index]['jumlah']}",
                          ),
                          // SizedBox(
                          //   width: 15,
                          // ),
                          // Text(
                          //   "Jenis: ${snapshot.data?[index]['jenis_barang']}",
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        // return Text("");
      },
    );
  }
}
