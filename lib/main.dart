import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   body: SafeArea(child: MyStatelessWidget()),
      // ),
      home: HomeScreen(),
      // home: MyHomePage(title: "Tahu",),
      // home: Scaffold(
      //   body: Transaksi(),
      // ),
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

  String _cariTransaksi = '';
  String _orderBy       = 'nama_barang';

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

                        _searchTransaksi(nama_barang: _cariTransaksi, order: value.toString());
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransaksiCard extends StatelessWidget {
  const TransaksiCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: TransaksiApi().getData(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            // scrollDirection: Axis.vertical,
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
        } else if (snapshot.hasError) {
          Text("Error");
        }

        return Text("");
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await TransaksiProvider().getTransaksi();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
