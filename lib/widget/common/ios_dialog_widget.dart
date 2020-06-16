import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showIosDialogWidget(context,
    {String title, String subTitle, Widget subWidget, Function onOkTap, Function onCancelTap}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: CupertinoAlertDialog(
            title: Text(title ?? '我是标题'),
            content: subTitle == null ? subWidget : Text(subTitle ?? '我是content'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  onOkTap();
                },
              ),
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {
                  onCancelTap();
                },
              ),
            ],
          ),
        );
      });
}
