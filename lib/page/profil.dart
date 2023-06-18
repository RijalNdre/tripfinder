import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgo/auth/login.dart';
import 'package:travelgo/page/cari_lokasi.dart';
import 'package:travelgo/services/auth_service.dart';
import 'package:travelgo/services/profil_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelgo/page/edit_profil.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const EditProfil(),
              ),
            ).then((_) {
              setState(() {});
            }),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.grey,
                      ),
                Positioned(
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                  bottom: -10,
                  left: 80,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 70, 69, 69)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Rizal Andrias M",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 70, 69, 69)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Jember",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 70, 69, 69)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "rijalndreas@gmail.com",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 70, 69, 69)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "098678456234",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              child: ElevatedButton.icon(
                  icon: Icon(Icons.pin_drop),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CariLokasi(),
                      ),
                    );
                  },
                  label: Text(
                    'Lihat lokasi saya',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 30),
              child: ElevatedButton(
                onPressed: () {
                  GoogleAuth().logout().then((_) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginApp(),
                        ),
                        (route) => false);
                  });
                  SharedPreferences.getInstance().then((pref) {
                    pref.remove("id");
                  });
                },
                child: Text('Logout'),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                    fixedSize: MaterialStatePropertyAll(Size(100, 40))),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
