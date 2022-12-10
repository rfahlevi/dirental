// ignore_for_file: unused_local_variable, avoid_print, body_might_complete_normally_nullable

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dirental/custom_lib/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  File? image;

  final _picker = ImagePicker();

  // Mendapatkan Gambar dari galeri
  Future _getImage() async {
    var img = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(img!.path);
    });
  }

  final _key = GlobalKey<FormState>();
  TextEditingController merkController = TextEditingController();
  TextEditingController nopolController = TextEditingController();
  TextEditingController transmisiController = TextEditingController();
  TextEditingController hargaController = TextEditingController();

// Insert data ke database
  Future _onSubmit() async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("http://192.168.200.236/dirental/create.php"),
      );
      request.fields['merk'] = merkController.text;
      request.fields['nopol'] = nopolController.text;
      request.fields['transmisi'] = transmisiController.text;
      request.fields['harga_sewa'] = hargaController.text;

      var pic = await http.MultipartFile.fromPath(
        "image",
        image!.path,
        filename: path.basename(image!.path),
      );
      request.files.add(pic);
      await request.send().then((result) {
        http.Response.fromStream(result).then((response) {
          var message = jsonDecode(response.body);
          final alert = Fluttertoast.showToast(msg: 'Input berhasil');
          setState(() {
            image = null;
            merkController = TextEditingController();
            nopolController = TextEditingController();
            transmisiController = TextEditingController();
            hargaController = TextEditingController();
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    (image != null)
                        ? Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: lighBlackColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.file(File(image!.path).absolute),
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: lighBlackColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.image_outlined,
                              color: whiteColor,
                              size: 50,
                            ),
                          ),
                    const SizedBox(
                      width: 14,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => blueColor,
                        ),
                      ),
                      onPressed: () {
                        _getImage();
                      },
                      child: Text(
                        "Upload Image",
                        style: whiteTextStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  width: MediaQuery.of(context).size.width - 48,
                  height: 50,
                  child: TextFormField(
                    controller: merkController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Merk harus diisi';
                      }
                    },
                    style: whiteTextStyle,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.branding_watermark_outlined,
                        color: whiteColor,
                      ),
                      hintText: 'Merk Kendaraan',
                      hintStyle: whiteTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: lighBlackColor,
                      filled: true,
                      isDense: true,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  width: MediaQuery.of(context).size.width - 48,
                  height: 50,
                  child: TextFormField(
                    controller: nopolController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nomor Polisi harus diisi';
                      }
                    },
                    style: whiteTextStyle,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.no_accounts_outlined,
                        color: whiteColor,
                      ),
                      hintText: 'Nomor Polisi',
                      hintStyle: whiteTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: lighBlackColor,
                      filled: true,
                      isDense: true,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  width: MediaQuery.of(context).size.width - 48,
                  height: 50,
                  child: TextFormField(
                    controller: transmisiController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Transmisi harus diisi';
                      }
                    },
                    style: whiteTextStyle,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.build_circle_outlined,
                        color: whiteColor,
                      ),
                      hintText: 'Transmisi',
                      hintStyle: whiteTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: lighBlackColor,
                      filled: true,
                      isDense: true,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  width: MediaQuery.of(context).size.width - 48,
                  height: 50,
                  child: TextFormField(
                    controller: hargaController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Harga Sewa harus diisi';
                      }
                    },
                    style: whiteTextStyle,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.price_check_outlined,
                        color: whiteColor,
                      ),
                      hintText: 'Harga Sewa',
                      hintStyle: whiteTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: lighBlackColor,
                      filled: true,
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => blueColor,
                      ),
                    ),
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        setState(() {
                          _onSubmit();
                        });
                      }
                    },
                    child: Text(
                      "Tambah Data Kendaraan",
                      style: whiteTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
