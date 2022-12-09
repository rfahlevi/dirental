// ignore_for_file: unused_local_variable, avoid_print, body_might_complete_normally_nullable

import 'dart:io';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:dirental/custom_lib/theme.dart';
import 'package:dirental/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  String? id;
  EditPage({super.key, required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  File? image;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  // Mendapatkan data berdasarkan id
  Future _getData() async {
    try {
      final response = await http
          .post(Uri.parse("http://192.168.89.39/dirental/detail.php"), body: {
        "id": widget.id,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          image = File(data['image']);
          merkController = TextEditingController(text: data['merk']);
          nopolController = TextEditingController(text: data['nopol']);
          transmisiController = TextEditingController(text: data['transmisi']);
          hargaController = TextEditingController(text: data['harga_sewa']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

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
  Future _onUpdate(context) async {
    try {
      await http
          .post(Uri.parse("http://192.168.89.39/dirental/update.php"), body: {
        "id": widget.id,
        "image": File(image!.path),
        "merk": merkController.text,
        "nopol": nopolController.text,
        "transmisi": transmisiController.text,
        "harga_sewa": hargaController.text,
      }).then((value) {
        var data = jsonDecode(value.body);
        print(data['message']);
        Get.to(() => const MainPage());
      });
    } catch (e) {
      print(e);
    }
  }

  Future _onDelete() async {
    try {
      await http
          .post(Uri.parse("http://192.168.89.39/dirental/delete.php"), body: {
        "id": widget.id,
      }).then((value) {
        var data = jsonDecode(value.body);
        print(data['message']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Edit Page",
          style: whiteTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                      "Ingin menghapus data?",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => blueColor,
                              ),
                            ),
                            onPressed: () => Get.back(),
                            child: Text(
                              "Batal",
                              style: whiteTextStyle,
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.resolveWith(
                                (states) => BorderSide(color: blueColor),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => whiteColor,
                              ),
                            ),
                            onPressed: () {
                              if (_onDelete() == true) {
                                Fluttertoast.showToast(
                                    msg: 'Data berhasil dihapus');
                                Get.to(const MainPage());
                              }
                            },
                            child: Text(
                              "Ya",
                              style: blueTextStyle,
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete_rounded),
            color: whiteColor,
          ),
        ],
      ),
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
                            child: Image.network(
                                'http://192.168.89.39/dirental/images/${image!.path}'),
                            // child: Image.file(File(image!.path).absolute),
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
                          _onUpdate(context);
                        });
                      }
                    },
                    child: Text(
                      "Update Data Kendaraan",
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
