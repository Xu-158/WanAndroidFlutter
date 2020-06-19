import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/common/global.dart';

class ErrorWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/image/not_found.png',
        fit: BoxFit.cover,
        height: winHeight,
      ),
    );
  }
}
