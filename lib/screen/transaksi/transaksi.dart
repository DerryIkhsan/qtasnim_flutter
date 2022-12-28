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
                margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 15),
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Colors.black.withOpacity(.6),
                      )
                    ]),
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${snapshot.data?[index]['tgl_transaksi']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.local_mall,
                            size: 70,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${snapshot.data?[index]['nama_barang']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${snapshot.data?[index]['jumlah']} item",
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.beenhere,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${snapshot.data?[index]['jenis_barang']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 20,
                                color: Colors.green,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Tersedia ${snapshot.data?[index]['stok_awal']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
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
