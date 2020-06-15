import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function onSubmitted;
  final double borderRadius;
  final double height;
  final double width;
  final bool autoFocus;
  bool isPassword;
  final bool showSuffixIcon;
  final String hintText;

  MyTextField(
      {this.controller,
      this.onSubmitted,
      this.borderRadius = 30,
      this.height = 50,
      this.width = double.infinity,
      this.autoFocus = false,
      this.isPassword = false,
      this.showSuffixIcon = false,
      this.hintText = ''});
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
//      alignment: Alignment.center,
      child: TextField(
        controller: widget.controller,
        onSubmitted: widget.onSubmitted,
        cursorColor: themeColor,
        autofocus: widget.autoFocus,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            suffix: widget.showSuffixIcon
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        child: Icon(Icons.remove_red_eye, color: themeColor),
                        onTap: () {
                          widget.isPassword = !widget.isPassword;
                          setState(() {});
                        },
                      ),
                      InkWell(
                        child: Icon(Icons.clear, color: themeColor),
                        onTap: () => widget.controller.clear(),
                      )
                    ],
                  )
                : SizedBox(),
            contentPadding: const EdgeInsets.only(bottom: 8, left: 10),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(widget.borderRadius)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(widget.borderRadius)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(widget.borderRadius))),
      ),
    );
  }
}