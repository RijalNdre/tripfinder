import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelgo/page/buat_postingan.dart';
import 'package:travelgo/services/user_repository.dart';

class Tambah extends StatefulWidget {
  const Tambah({super.key});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ulasan',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const BuatPostingan(),
          ),
        ).then((_) {
          setState(() {});
        }),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: UlasanService.getAll(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final ulasan = snapshot.data?.docs ?? [];

          return ListView(
            padding: EdgeInsets.all(10),
            children: ulasan
                .map(
                  (e) => Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Center(
                                  child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(e["image"]),
                          ))),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            e["judul"],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(e["isi"]),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (_) => EditPage(
                          //             userId: e.id,
                          //             judul: e["judul"],
                          //             isi: e["isi"],
                          //           ),
                          //         ),
                          //       ).then((_) {
                          //         setState(() {});
                          //       });
                          //     },
                          //     child: Text('edit'))
                          IconButton(
                            onPressed: () {
                              UlasanService.delete(userId: e.id).then((_) {
                                setState(() {});
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
