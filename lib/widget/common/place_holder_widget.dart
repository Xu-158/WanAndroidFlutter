import 'package:flutter/material.dart';

class PlaceHolderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Image.asset(
        'assets/image/timg.gif',
        fit: BoxFit.fill,
      ),
    );
  }
}
