import 'package:dirental/auth/login_page.dart';
import 'package:dirental/custom_lib/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => blueColor,
                  ),
                ),
                onPressed: () {
                  Get.to(() => const LoginPage());
                },
                child: Text(
                  "Logout",
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
