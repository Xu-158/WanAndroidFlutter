import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: winHeight*0.9,
        child: Column(
          children: <Widget>[
            Text(
              '暂无数据',
              style: TextStyle(fontSize: 30),
            ),
            Icon(Icons.clear, size: 40)
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
