// ignore_for_file: must_be_immutable

import 'package:dirental/custom_lib/theme.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  VoidCallback onTap;

  CustomCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: lighBlackColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/avanza.png',
                    width: 150,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Avanza 2022",
                    style: whiteTextStyle,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "B 3062 KWA",
                    style: whiteTextStyle,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Transmisi Manual",
                    style: whiteTextStyle,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Rp.300.000 / Hari",
                    style: blueTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
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
