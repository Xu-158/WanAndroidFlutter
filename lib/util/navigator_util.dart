import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PushType {
  material,
  cupertino,
}

class NavigatorUtil {
  static GlobalKey<NavigatorState> navKey = GlobalKey();

  static Route pushUtil(PushType pushType, Widget page) {
    Route route;
    switch (pushType) {
      case PushType.material:
        route = MaterialPageRoute(builder: (context) {
          return page;
        });
        break;
      case PushType.cupertino:
        route = CupertinoPageRoute(builder: (context) {
          return page;
        });
        break;
    }
    return route;
  }

  static Future push(Widget page, {PushType type = PushType.cupertino}) {
    return navKey.currentState.push(pushUtil(type, page));
  }

  static Future<dynamic> maybePop([result]) {
    return navKey.currentState.maybePop(result ?? '');
  }

  static void popToRootPage() {
    return navKey.currentState.popUntil(ModalRoute.withName('/'));
  }

  static Future pushAndRemoveUntil(Widget page,{PushType type = PushType.cupertino}){
    return navKey.currentState.pushAndRemoveUntil(pushUtil(type, page), (route) => route == null);
  }
}
