import 'package:flutter/material.dart';

class SmallWidget extends StatelessWidget {
  final String text;
  final Widget textWidget;
  final Color bgColor;
  final Color fontColor;
  final double fontSize;
  final double width;

  const SmallWidget(
      {Key key,
      this.text = '',
      this.bgColor = Colors.transparent,
      this.fontColor = Colors.black,
      this.fontSize = 16.0,
      this.textWidget,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: textWidget == null
          ? Text(
              text,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: fontColor, fontSize: fontSize),
            )
          : textWidget,
    );
  }
}
