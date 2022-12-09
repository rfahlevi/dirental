import 'package:dirental/auth/login_page.dart';
import 'package:dirental/custom_lib/customField.dart';
import 'package:dirental/custom_lib/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
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
                        "Register",
                        style: whiteTextStyle.copyWith(
                          fontSize: 30,
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        "Silahkan buat akun anda",
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextFormField(
                        hintText: 'Username',
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: whiteColor,
                        ),
                        controller: usernameController,
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
                            Get.to(const LoginPage());
                          },
                          child: Text(
                            "Buat Akun",
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
                            text: 'Sudah punya akun? ',
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      ),
                                text: 'Masuk',
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
