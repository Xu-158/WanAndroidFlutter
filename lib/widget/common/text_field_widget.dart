import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onSubmitted;
  final double borderRadius;
  final double height;
  final double width;
  final bool autoFocus;
  final bool isPassword;

  MyTextField(
      {this.controller,
      this.onSubmitted,
      this.borderRadius = 30,
      this.height = 50,
      this.width = double.infinity,
      this.autoFocus = false,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        cursorColor: themeColor,
        autofocus: autoFocus,
        obscureText: isPassword,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(borderRadius)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(borderRadius))),
      ),
    );
  }
}
