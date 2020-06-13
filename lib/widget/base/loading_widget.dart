import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black54.withOpacity(0.2)),
          width: winWidth,
          height: winHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoActivityIndicator(
                radius: 25.px,
                animating: true,
              ),
              Text('loading',style: TextStyle(
                color: Colors.grey,
                fontSize: 18
              ),)
            ],
          ),
        ));
  }
}
