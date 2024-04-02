import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormKontak extends StatefulWidget {
  const FormKontak({
    super.key,
  });

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  final _formkey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noTeleponController = TextEditingController();

  File? _image;
  final _imagePicker = ImagePicker();

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("No image selected");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: "Nama",
                  hintText: "Masukkan Nama Anda",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "email",
                  hintText: "Masukkan Email Anda",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: "Alamat",
                  hintText: "Masukkan Alamat Anda",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _noTeleponController,
                decoration: InputDecoration(
                  labelText: "Nomor Telepon",
                  hintText: "Masukkan Nomor Telepon Anda",
                ),
              ),
            ),
            _image == null
                ? const Text("Belum ada gambar yang dipilih")
                : Image.file(_image!),
            ElevatedButton(
              onPressed: getImage,
              child: const Text("Pilih Gambar"),
            ),
            Container(
              margin: const EdgeInsets.all(10),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Pilih Gambar")),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(onPressed: () {}, child: Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}
