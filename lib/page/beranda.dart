import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travelgo/page/cari_lokasi.dart';

class Beranda extends StatelessWidget {
  final String email;
  const Beranda({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Selamat Datang',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Rizal Andrias M',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        toolbarHeight: 150,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.blue),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 30),
            child: Image.asset(
              'assets/images/logo.png',
              width: 80,
              height: 80,
            ),
          )
        ],
      ),
      body: HalBeranda(),
    ));
  }
}

class HalBeranda extends StatefulWidget {
  @override
  State<HalBeranda> createState() => _HalBerandaState();
}

class _HalBerandaState extends State<HalBeranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton.icon(
                    icon: Opacity(
                      opacity: 0.4,
                      child: Image.asset('assets/images/search.png',
                          width: 25, height: 25),
                    ),
                    onPressed: () {},
                    label: Text(
                      'Cari lokasi wisata yang kamu mau',
                      style: TextStyle(color: Colors.grey),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: Size(0, 50))),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  'Jalan - jalan yuk',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/images/promo1.jpg'),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 20),
                child: Text(
                  'Top Rated',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  margin: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/papuma.png',
                      width: 50,
                      height: 50,
                    ),
                    title: Text('Pantai Papuma'),
                    subtitle: Text(
                        'Pantai Papuma menawarkan kombinasi sempurna antara pantai berpasir putih dan air laut yang jernih'),
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  margin: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: ListTile(
                    leading: Image.asset('assets/images/baluran.png',
                        width: 50, height: 50),
                    title: Text('Taman Nasional Baluran'),
                    subtitle: Text(
                        'Sebuah wilayah konservasi alam yang terletak di Banyuwangi dan tidak jauh dengan pelabuhan'),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
