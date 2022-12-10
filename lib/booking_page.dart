import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dirental/custom_lib/theme.dart';
import 'package:dirental/data_booking_page.dart';
import 'package:dirental/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  String? id;
  double lamaSewa;
  BookingPage({
    super.key,
    required this.id,
    required this.lamaSewa,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  File? image;
  String? merk;
  String? nopol;
  String? transmisi;
  double lamaSewa = 0;
  int kodeBooking = Random().nextInt(100000) + 99999;

  double harga = 0;

  Future _getData() async {
    try {
      final response = await http
          .post(Uri.parse("http://192.168.200.236/dirental/detail.php"), body: {
        "id": widget.id,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          image = File(data['image']);
          merk = data['merk'];
          nopol = data['nopol'];
          transmisi = data['transmisi'];
          harga = double.tryParse(data['harga_sewa'])!;
          lamaSewa = widget.lamaSewa;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onSimpan() async {
    final total = harga * lamaSewa;
    final totalBiaya = double.tryParse(total.toString());
    try {
      final response = await http.post(
          Uri.parse("http://192.168.200.236/dirental/booking.php"),
          body: {
            "nama": 'Reza Fahlevi',
            "email": 'levicubs@gmail.com',
            "merk": merk,
            "transmisi": transmisi,
            "harga_sewa": harga.toString(),
            "lama_sewa": lamaSewa.toString(),
            "total_biaya": totalBiaya.toString(),
            "kode_booking": kodeBooking.toString(),
          }).then((value) {
        var data = jsonDecode(value.body);
        print(data['message']);
        Navigator.of(context).push(
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
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        appBar: AppBar(
          title: Text(
            "Konfirmasi Pemesanan",
            style: whiteTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  height: 2,
                  thickness: 2,
                  color: whiteColor,
                ),
                const SizedBox(
                  height: 7,
                ),
                Center(
                  child: Text(
                    "dirental.",
                    style: whiteTextStyle.copyWith(
                      fontSize: 30,
                      fontWeight: semiBold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: whiteColor,
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nama Pemesan",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      "Reza Fahlevi",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      "levicubs@gmail.com",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Unit Kendaraan",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      '$merk',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nomor Polisi",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      '$nopol',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Transmisi",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      '$transmisi',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Harga Sewa",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      '${NumberFormat.simpleCurrency(locale: 'id').format(double.parse(harga.toString()))} per Hari',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lama Sewa",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      '${lamaSewa.toStringAsFixed(0)} Hari',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Biaya",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: 'id')
                          .format(harga * lamaSewa),
                      style: blueTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: whiteColor,
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kode Booking",
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      kodeBooking.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: whiteColor,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => whiteColor.withOpacity(0.5))),
                    onPressed: () {
                      Get.to(const MainPage());
                    },
                    child: Text(
                      "Batal",
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => blueColor)),
                    onPressed: () {
                      _onSimpan();
                    },
                    child: Text(
                      "Simpan",
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
