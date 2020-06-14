import 'package:flutter/material.dart';
import 'package:wanandroidflutter/util/size_util.dart';

String baseUrl = 'https://www.wanandroid.com';

enum ReqStatus { success, error, loading }

enum UserStatus { login, logout }

extension Int on int {
  double get px {
    return SizeUtil.setPx(this.toDouble());
  }

  double get rpx {
    return SizeUtil.setRpx(this.toDouble());
  }
}

extension Double on double {
  double get px {
    return SizeUtil.setPx(this);
  }

  double get rpx {
    return SizeUtil.setRpx(this);
  }
}

double get winWidth => SizeUtil.screenWidth;

double get winHeight => SizeUtil.screenHeight;

///==============ThemeColor=============
Color get themeColor => Colors.blue;

Color get bottomNavBtnColor => Colors.grey;
