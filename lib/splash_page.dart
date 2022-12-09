import 'dart:async';

import 'package:dirental/custom_lib/theme.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
// Method untuk menjalankan halaman SplashPage selama 3 detik
  splashPage() async {
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () {
        Navigator.of(context).pushReplacementNamed('/login-page');
      },
    );
  }

  // Fungsi yang akan dijalankan pertama kali
  @override
  void initState() {
    super.initState();
    splashPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "diRental.",
            style: whiteTextStyle.copyWith(
              fontSize: 48,
              fontWeight: bold,
              fontStyle: FontStyle.italic,
            ),
          )
        ],
      )),
    );
  }
}
