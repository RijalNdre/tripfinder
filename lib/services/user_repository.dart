import 'package:cloud_firestore/cloud_firestore.dart';

class MyCollection {
  MyCollection._();
  static CollectionReference ulasan =
      FirebaseFirestore.instance.collection("ulasan");
}

class UlasanService {
  static Future<QuerySnapshot<Object?>> getAll() async {
    return await MyCollection.ulasan.get();
  }

  static Future insert({
    required String judul,
    required String isi,
    required String image,
  }) async {
    return await MyCollection.ulasan
        .add({"judul": judul, "isi": isi, "image": image});
  }

  static Future update({
    required String userId,
    required String judul,
    required String isi,
  }) async {
    return await MyCollection.ulasan.doc(userId).update({
      "judul": judul,
      "isi": isi,
    });
  }

  static Future delete({
    required String userId,
  }) async {
    return await MyCollection.ulasan.doc(userId).delete();
  }
}
