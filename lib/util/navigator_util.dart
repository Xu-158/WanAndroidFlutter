import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtil{
  static GlobalKey<NavigatorState> navKey = GlobalKey();

  static push(Widget page){
    navKey.currentState.push(MaterialPageRoute(
      builder: (context){
        return page;
      }
    ));
  }
}