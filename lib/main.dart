import 'package:flutter/material.dart';
import 'package:wanandroidflutter/root_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';

void main() {
  runApp(MyApp());

  ///沉浸式状态栏
//  if (Platform.isAndroid) {
//    SystemUiOverlayStyle systemUiOverlayStyle =
//        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
//    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterWanAndroid',
      navigatorKey: NavigatorUtil.navKey,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.white,
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => RootPage()
      },
    );
  }
}
