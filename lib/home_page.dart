// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, unused_element

import 'dart:convert';

import 'package:dirental/booking_page.dart';
import 'package:dirental/custom_lib/customField.dart';
import 'package:dirental/custom_lib/theme.dart';
import 'package:dirental/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController lamaSewaController = TextEditingController();

  List _get = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.200.236/dirental/list.php"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _get = data;
        });
      }
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                        hintText: 'Cari Kendaraan',
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: whiteColor,
                        ),
                        controller: searchController),
                    Text(
                      "Pilih Kendaraan",
                      style: whiteTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    _get.isNotEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                              ),
                              itemCount: _get.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onDoubleTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: const Text(
                                            "Ingin mengedit data?",
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    side: MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            BorderSide(
                                                              color: blueColor,
                                                            )),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .resolveWith(
                                                      (states) => whiteColor,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Batal",
                                                    style: blueTextStyle,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .resolveWith(
                                                      (states) => blueColor,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Get.to(
                                                      () => EditPage(
                                                          id: '${_get[index]['id']}'),
                                                    );
                                                  },
                                                  child: const Text(
                                                    "Ya",
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: whiteColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30)),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 20),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Buat Pesanan",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 20,
                                                    fontWeight: semiBold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Nama Pemesan",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                  Text(
                                                    "Reza Fahlevi",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Email",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                  Text(
                                                    "levicubs@gmail.com",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Type",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                  Text(
                                                    '${_get[index]['merk']}',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Nomor Polisi",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                  Text(
                                                    '${_get[index]['nopol']}',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Transmisi",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                  Text(
                                                    '${_get[index]['transmisi']}',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Harga",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight: medium),
                                                  ),
                                                  Text(
                                                    '${NumberFormat.simpleCurrency(locale: 'id').format(double.parse(_get[index]['harga_sewa']))} / Hari',
                                                    style:
                                                        blueTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                semiBold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Lama Sewa (Hari)",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: medium,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 40,
                                                    child: TextFormField(
                                                      controller:
                                                          lamaSewaController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: '0',
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        isDense: true,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    48,
                                                height: 50,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .resolveWith(
                                                      (states) => blueColor,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    final merkKendaraan =
                                                        '${_get[index]['merk']}';
                                                    final nopolKendaraan =
                                                        '${_get[index]['nopol']}';
                                                    final transmisiKendaraan =
                                                        '${_get[index]['transmisi']}';
                                                    double? hargaSewa =
                                                        double.tryParse(
                                                            _get[index]
                                                                ['harga_sewa']);
                                                    final lamaSewa =
                                                        double.tryParse(
                                                            lamaSewaController
                                                                .text);

                                                    try {
                                                      if (lamaSewaController
                                                          .text.isEmpty) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              content: Text(
                                                                "Lama Sewa harus diisi",
                                                                style: blackTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            medium),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              actions: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Get.back();
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Oke",
                                                                        style:
                                                                            whiteTextStyle,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        setState(() {});
                                                      } else {
                                                        Get.to(
                                                            () => BookingPage(
                                                                  id: '${_get[index]['id']}',
                                                                  lamaSewa: double
                                                                      .tryParse(
                                                                          lamaSewaController
                                                                              .text)!,
                                                                ));
                                                      }
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  },
                                                  child: Text(
                                                    "Booking",
                                                    style:
                                                        whiteTextStyle.copyWith(
                                                      fontSize: 18,
                                                      fontWeight: semiBold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color: lighBlackColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image(
                                                height: 70,
                                                image: NetworkImage(
                                                    'http://192.168.200.236/dirental/images/' +
                                                        _get[index]['image']),
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                '${_get[index]['merk']}',
                                                style: whiteTextStyle,
                                              ),
                                              Text(
                                                '${_get[index]['nopol']}',
                                                style: whiteTextStyle,
                                              ),
                                              Text(
                                                '${_get[index]['transmisi']}',
                                                style: whiteTextStyle,
                                              ),
                                              Text(
                                                '${NumberFormat.simpleCurrency(locale: 'id').format(double.parse(_get[index]['harga_sewa']))} / Hari',
                                                style: blueTextStyle.copyWith(
                                                  fontWeight: semiBold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  color: blueColor,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "Belum ada data kendaraan",
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: semiBold,
                                  ),
                                )
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
