import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: winWidth,
        height: winHeight,
        child: Center(
            child: CircularProgressIndicator()
        )
    );
  }
}
