import 'package:travelgo/services/user_repository.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String userId;
  final String judul;
  final String isi;

  const EditPage({
    super.key,
    required this.userId,
    required this.judul,
    required this.isi,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _controllerJudul;
  late TextEditingController _controllerIsi;

  @override
  void initState() {
    _controllerJudul = TextEditingController(
      text: widget.judul,
    );
    _controllerIsi = TextEditingController(
      text: widget.isi,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text("Judul"),
          TextField(
            controller: _controllerJudul,
          ),
          const Text("Isi"),
          TextField(
            controller: _controllerIsi,
          ),
          ElevatedButton(
            onPressed: () {
              UlasanService.update(
                userId: widget.userId,
                judul: _controllerJudul.text,
                isi: _controllerIsi.text,
              ).then(
                (_) => Navigator.pop(context),
              );
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
