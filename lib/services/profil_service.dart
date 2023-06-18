import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
}

class MyCollection {
  MyCollection._();
  static CollectionReference profil =
      FirebaseFirestore.instance.collection("profil");
}

class ProfilService {
  static Future<QuerySnapshot<Object?>> getAll() async {
    return await MyCollection.profil.get();
  }

  static Future insert({
    required String alamat,
    required String email,
    required String nama,
    required String notelp,
    required String image,
  }) async {
    return await MyCollection.profil.add({
      "alamat": alamat,
      "email": email,
      "nama": nama,
      "notelp": notelp,
      "image": image
    });
  }

  static Future update({
    required String userId,
    required String alamat,
    required String email,
    required String nama,
    required String notelp,
    required String image,
  }) async {
    return await MyCollection.profil.doc(userId).update({
      "alamat": alamat,
      "email": email,
      "nama": nama,
      "notelp": notelp,
      "image": image
    });
  }

  static Future delete({
    required String userId,
  }) async {
    return await MyCollection.profil.doc(userId).delete();
  }
}
