import 'package:dirental/auth/login_page.dart';
import 'package:dirental/auth/register_page.dart';
import 'package:dirental/home_page.dart';
import 'package:dirental/main_page.dart';
import 'package:dirental/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/login-page': (context) => const LoginPage(),
        '/register-page': (context) => const RegisterPage(),
        '/home-page': (context) => const HomePage(),
      },
      home: const SplashPage(),
    );
  }
}
