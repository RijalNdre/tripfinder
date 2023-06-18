import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelgo/page/beranda.dart';
import 'package:travelgo/page/buat_postingan.dart';
import 'package:travelgo/page/cari_wisata.dart';
import 'package:travelgo/page/ulasan.dart';
import 'package:travelgo/page/profil.dart';
import 'package:travelgo/page/ulasan.dart';

class Navigasi extends StatefulWidget {
  @override
  State<Navigasi> createState() => _NavigasiState();
}

class _NavigasiState extends State<Navigasi> {
  int selectBar = 0;

  List<Widget> pages = [
    const Beranda(
      email: '',
    ),
    const CariWisata(),
    const Tambah(),
    const Profil(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: pages[selectBar],
          bottomNavigationBar: Container(
            child: BottomNavigationBar(
              currentIndex: selectBar,
              onTap: (value) {
                setState(() {
                  selectBar = value;
                });
              },
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
            ),
          ),
        ));
  }
}
