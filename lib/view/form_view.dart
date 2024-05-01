import 'dart:io';

import 'package:data_kontak/controller/kontak_controller.dart';
import 'package:data_kontak/model/kontak.dart';
import 'package:data_kontak/view/home_view.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Masukkan Data"),
        ),
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Nama", hintText: "Masukkan Nama Anda"),
                    controller: _namaController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Email", hintText: "Masukkan Email Anda"),
                    controller: _emailController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Alamat", hintText: "Masukkan Alamat Anda"),
                    controller: _alamatController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "No Handphone",
                        hintText: "Masukkan No Handphone Anda"),
                    controller: _noTeleponController,
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
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        var result = await KontakController().addPerson(
                          Kontak(
                              nama: _namaController.text,
                              email: _emailController.text,
                              alamat: _alamatController.text,
                              telepon: _noTeleponController.text,
                              foto: _image!.path),
                          _image,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              result['message'],
                            ),
                          ),
                        );
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()),
                            (route) => false);
                      }
                    },
                    child: const Text("Simpan"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
