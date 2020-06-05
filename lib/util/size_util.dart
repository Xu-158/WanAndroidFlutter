import 'package:flutter/cupertino.dart';

class SizeUtil{
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double rpx;
  static double px;

  static void initSize(BuildContext context,{double standardWidth = 750}){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
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