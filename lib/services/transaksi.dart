part of 'services.dart';

class TransaksiApi{
  Future<List<dynamic>> getData({String nama_barang = ''}) async {
    var transaksiGet            = Uri.parse("$api/transaksi/get.php");
    var responseTransaksiGet    = await http.post(transaksiGet, body: {
      'nama_barang': nama_barang
    });

    dynamic data;
    List<dynamic> resultGet     = [];

    if(responseTransaksiGet.statusCode == 200){
      data        = json.decode(responseTransaksiGet.body);
      resultGet   = data['result'] ?? [];
    }

    return resultGet;
  }
}