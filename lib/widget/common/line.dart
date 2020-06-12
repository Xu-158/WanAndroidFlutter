import 'package:flutter/material.dart';

/// 横线
class HorizontalLine extends StatelessWidget {
  final double height;
  final Color color;
  final double horizontal;

  HorizontalLine({
    this.height = 10,
    this.color = Colors.grey,
    this.horizontal = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: height,
      color: color,
      margin: new EdgeInsets.symmetric(horizontal: horizontal),
    );
  }
}

/// 竖线
class VerticalLine extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double vertical;

  VerticalLine({
    this.width = 1.0,
    this.height = 25,
    this.color = Colors.grey,
    this.vertical = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: width,
      color: Color(0xffDCE0E5),
      margin: new EdgeInsets.symmetric(vertical: vertical),
      height: height,
    );
  }
}