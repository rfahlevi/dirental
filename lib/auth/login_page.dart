// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:dirental/auth/register_page.dart';
import 'package:dirental/custom_lib/customField.dart';
import 'package:dirental/custom_lib/theme.dart';
import 'package:dirental/home_page.dart';
import 'package:dirental/main_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username;
  bool _isHidePassword = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  void _tampil() {
    Fluttertoast.showToast(
      msg: 'Failed Login',
      // // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.CENTER,
      // timeInSecForIosWeb: 1,
      // backgroundColor: Colors.red,
      // textColor: whiteColor,
      // fontSize: 20
    );
  }

  Future _login() async {
    try {
      final response = await http.post(
          Uri.parse("http://192.168.154.39/login_multiuser/login.php"),
          body: {
            "username": usernameController.text,
            "password": passwordController.text,
          });

      var dataUser = json.decode(response.body);

      if (dataUser.length == 0) {
        setState(() {
          _tampil();
        });
      } else {
        if (dataUser[0]['level'] == 'admin') {
          Get.to(const HomePage());
        } else if (dataUser[0]['level'] == 'user') {
          Navigator.pushReplacementNamed(context, '/home-page-user');
        }

        setState(() {
          username = dataUser[0]['username'];
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: whiteTextStyle.copyWith(
                          fontSize: 30,
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        "Silahkan masuk dengan akun anda",
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextFormField(
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: whiteColor,
                        ),
                        controller: usernameController,
                      ),
                      CustomTextFormField(
                        hintText: 'Password',
                        obscureText: _isHidePassword,
                        prefixIcon: Icon(
                          Icons.lock_open_rounded,
                          color: whiteColor,
                        ),
                        suffixIcon: GestureDetector(
                          child: IconButton(
                            onPressed: () {
                              _togglePassword();
                            },
                            icon: _isHidePassword
                                ? Icon(
                                    Icons.visibility_off_outlined,
                                    color: whiteColor,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: whiteColor,
                                  ),
                          ),
                        ),
                        controller: passwordController,
                        isDense: true,
                      ),
                      Text(
                        "Lupa Password?",
                        style: whiteTextStyle,
                      ),
                      const SizedBox(
                        height: 24,
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
                            // _login();
                            Get.to(const MainPage());
                          },
                          child: Text(
                            "Masuk",
                            style: whiteTextStyle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Belum Punya Akun? ',
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage(),
                                        ),
                                      ),
                                text: 'Buat Akun',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
