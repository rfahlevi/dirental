import 'dart:convert';

import 'package:dirental/custom_lib/theme.dart';
import 'package:dirental/main_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DataBookingPage extends StatefulWidget {
  const DataBookingPage({super.key});

  @override
  State<DataBookingPage> createState() => _DataBookingPageState();
}

class _DataBookingPageState extends State<DataBookingPage> {
  List _get = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.200.236/dirental/booking_list.php"),
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

  Future _onDelete(String id) async {
    try {
      await http.post(
          Uri.parse("http://192.168.200.236/dirental/booking_delete.php"),
          body: {
            "id": id,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: _get.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: _get.length,
                    itemBuilder: (context, index) {
                      final idBooking = _get[index]['id'];
                      return GestureDetector(
                        onTap: () {
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                          side:
                                              MaterialStateProperty.resolveWith(
                                            (states) =>
                                                BorderSide(color: blueColor),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                            (states) => whiteColor,
                                          ),
                                        ),
                                        onPressed: () {
                                          _onDelete(idBooking);
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
                        child: Card(
                          color: lighBlackColor,
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kode Booking : ${_get[index]['kode_booking']}',
                                  style: blueTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${_get[index]['nama']}',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                Text(
                                  '${_get[index]['email']}',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(locale: 'id')
                                      .format(double.parse(
                                          _get[index]['total_biaya'])),
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: semiBold,
                                  ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: blueColor,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        "Belum ada data booking",
                        style: whiteTextStyle.copyWith(
                            fontSize: 24, fontWeight: semiBold),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
