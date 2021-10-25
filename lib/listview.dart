import 'dart:convert';

import 'package:bt_nangcao12/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp4 extends StatelessWidget {
  const MyApp4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListViewAdvanced(),
    );
  }
}

class ListViewAdvanced extends StatefulWidget {
  const ListViewAdvanced({Key? key}) : super(key: key);

  @override
  _ListViewAdvancedState createState() => _ListViewAdvancedState();
}

class _ListViewAdvancedState extends State<ListViewAdvanced> {
  List<Product> _list = [];
  var loading = false;
  Future<Null> _fetchData() async {
    String url = "https://fakestoreapi.com/products";
    var client = http.Client();
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _list.add(Product.fromJson(i));
        }
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var count = 0 ;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Listview Nâng cao"),
      ),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, i) {
            final x = _list[i];
            return Card(
              elevation: 4,
              child: Column(
                children: [
                  Image.network(
                    "${x.image}",
                    width: size.width * 0.3,
                    height: size.height * 0.110,
                  ),
                  Container(
                      width: size.width * 0.55,
                      height: size.height * 0.05,
                      child: Text(
                        "${x.title}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  SizedBox(
                    height: size.height * 0.004,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "${x.price}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                StatefulBuilder(builder: (context, setState) {
                                  return AlertDialog(
                                    title: const Text('Mua hàng ngay'),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(width: 20),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                count++;
                                              });
                                            },
                                            icon: Icon(Icons.add)),
                                        Text("$count"),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (count > 0) count--;
                                              });
                                            },
                                            icon: Icon(Icons.minimize)),
                                        SizedBox(width: 20)
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Để sau'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Mua'),
                                      ),
                                    ],
                                  );
                                })),
                        child: const Text('Mua Ngay'),
                      ),
                      Icon(
                        Icons.car_rental,
                        color: Colors.green,
                        size: 30.0,
                      ),
                      Container(
                        child: Text(
                          "${x.rating.rate}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Text(
                          "${x.rating.count}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
      // [
      //   Card(
      //     elevation: 4,
      //     child: Column(
      //       children: [
      //         Text("${p.title}"),
      //         Text("${p.category}"),
      //         Text("${p.description}"),
      //         Row(
      //           children: [
      //             Text("${p.price}"),
      //           ],
      //         )
      //       ],
      //     ),
      //   ),
      // ]
    );
  }
}
