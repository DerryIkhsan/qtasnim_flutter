import 'dart:async';
import 'transaksi_provider.dart';

class TransaksiBloc{
  final transaksiController = StreamController();
  final transaksiProvider   = TransaksiProvider();

  Stream get getTransaksi => transaksiController.stream;

  void updateTransaksi({String nama_barang = '', String order = ''}){
    transaksiProvider.getTransaksi(nama_barang: nama_barang, order: order);
    transaksiController.sink.add(transaksiProvider.transaksi);
  }

  void dispose(){
    transaksiController.close();
  }
}

final transaksiBloc = TransaksiBloc();