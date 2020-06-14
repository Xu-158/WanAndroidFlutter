import 'package:flutter/material.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';

class BackButton1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios,color: Colors.white),
      onPressed: ()=>NavigatorUtil.maybePop(),
    );
  }
}
