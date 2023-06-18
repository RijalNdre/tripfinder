import 'dart:io';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo/page/profil.dart';
import 'package:travelgo/services/profil_service.dart';
import 'package:travelgo/services/user_repository.dart';
import 'package:travelgo/services/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({super.key});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerNotelp = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('ulasan');

  String imageUrl = "";
  String url = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 5),
              child: TextFormField(
                controller: _controllerNama,
                decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: TextFormField(
                controller: _controllerAlamat,
                decoration: InputDecoration(
                    labelText: 'Alamat',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: TextFormField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: TextFormField(
                controller: _controllerNotelp,
                decoration: InputDecoration(
                    labelText: 'No. Telpon',
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
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                ProfilService.insert(
                        alamat: _controllerAlamat.text,
                        email: _controllerEmail.text,
                        nama: _controllerNama.text,
                        notelp: _controllerNotelp.text,
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
