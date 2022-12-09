// ignore_for_file: file_names, must_be_immutable, body_might_complete_normally_nullable

import 'package:dirental/custom_lib/theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String? hintText;
  Icon? prefixIcon;
  GestureDetector? suffixIcon;
  TextEditingController? controller;
  bool obscureText;
  bool isDense;
  String? validator;

  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.isDense = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      width: MediaQuery.of(context).size.width - 48,
      height: 50,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return validator;
          }
        },
        style: whiteTextStyle,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffix: suffixIcon,
          suffixIconColor: whiteColor,
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: whiteTextStyle,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: lighBlackColor,
          filled: true,
          isDense: isDense,
        ),
      ),
    );
  }
}
