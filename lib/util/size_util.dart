
import 'dart:ui';

import 'package:flutter/material.dart';

class SizeUtil{
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double statusBarHeight; // 状态栏高度
  static double navigationBarHeight = kToolbarHeight; //navigationBar高度
  static double rpx;
  static double px;

  static void initSize(BuildContext context,{double standardWidth = 750}){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    statusBarHeight = MediaQueryData.fromWindow(window).padding.top;
    rpx = screenWidth/standardWidth;
    px = screenWidth/standardWidth *2;
  }

  static double setPx(double size){
    return rpx*size*2;
  }

  static double setRpx(double size){
    return rpx*size;
  }
}