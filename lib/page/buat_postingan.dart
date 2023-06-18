import 'dart:io';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo/services/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BuatPostingan extends StatefulWidget {
  const BuatPostingan({super.key});

  @override
  State<BuatPostingan> createState() => _BuatPostinganState();
}

class _BuatPostinganState extends State<BuatPostingan> {
  final TextEditingController _controllerJudul = TextEditingController();
  final TextEditingController _controllerIsi = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('ulasan');

  String imageUrl = "";
  String url = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Ulasan"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              child: TextFormField(
                controller: _controllerJudul,
                decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 30),
              child: TextFormField(
                controller: _controllerIsi,
                decoration: InputDecoration(
                    labelText: 'Isi',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            IconButton(
                onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.camera);
                  print('${file?.path}');
                  if (file == null) return;
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images');
                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);
                  UploadTask upload =
                      referenceImageToUpload.putFile(File(file!.path));
                  var downUrl = await (await upload).ref.getDownloadURL();
                  url = downUrl.toString();

                  print("Download url : $url");
                },
                icon: Icon(
                  Icons.camera_alt,
                  size: 40,
                )),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                UlasanService.insert(
                        judul: _controllerJudul.text,
                        isi: _controllerIsi.text,
                        image: url)
                    .then(
                  (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("User berhasil ditambahkan"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  },
                );
              },
              child: const Text("Tambah"),
            ),
          ],
        ),
      ),
    );
  }
}
