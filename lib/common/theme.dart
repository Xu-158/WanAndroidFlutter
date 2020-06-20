import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/util/sp_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

class AppTheme extends BaseModel {
  String themeColor = 'blue';

  setThemeColor(String colorName) {
    themeColor = colorName;
    setState(ReqStatus.success);
    notifyListeners();
  }

  Color get getThemeColor => themeColorMap[themeColor];

  String get getThemeColorName => themeColor;
}

Map<String, Color> themeColorMap = {
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'cyan': Colors.cyan,
  'deepPurple': Colors.purple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'deepOrange': Colors.orange,
  'green': Colors.green,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'red': Colors.red,
  'teal': Colors.teal,
  'black': Colors.black,
};

showColorPick(context, tColor) {
  return showDialog(
      context: context,
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: <Widget>[
              GestureDetector(onTap: () {
                NavigatorUtil.maybePop();
              }),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 130.px,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: themeColorMap.keys.map((value) {
                      return InkWell(
                        child: Container(
                          height: 25,
                          width: 25,
                          color: themeColorMap[value],
                        ),
                        onTap: () {
                          tColor.setThemeColor(value);
                          SPUtil.setData(
                              type: String,
                              key: SPUtil.themeColor,
                              value: tColor.getThemeColorName);
                          showToast(message: '修改成功');
                          NavigatorUtil.maybePop();
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
