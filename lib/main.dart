import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/root_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/util/path_util.dart';
import 'package:wanandroidflutter/util/sp_util.dart';

import 'common/theme.dart';

void main() async {
  /// 初始化
  WidgetsFlutterBinding.ensureInitialized();

  PathUtil.getTemporary().then((value) => runApp(MyApp()));

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppTheme()),
      ],
      child: Consumer<AppTheme>(
        builder: (context, model, child) {
          SPUtil.get(type: String, key: SPUtil.themeColor, defaultValue: 'red')
              .then((value) => model.setThemeColor(value));
          return MaterialApp(
            title: 'FlutterWanAndroid',
            navigatorKey: NavigatorUtil.navKey,
            theme: ThemeData(
              cupertinoOverrideTheme: CupertinoThemeData(
                primaryColor: model.getThemeColor,
                primaryContrastingColor: model.getThemeColor,
                barBackgroundColor: model.getThemeColor,
//                Brightness brightness,
//                Color primaryColor,
//                Color primaryContrastingColor,
//                CupertinoTextThemeData textTheme,
//                Color barBackgroundColor,
//                Color scaffoldBackgroundColor,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: model.getThemeColor.withOpacity(0.8),
              ),
              scaffoldBackgroundColor: Colors.white,
              primaryColor: model.getThemeColor,
              cardColor: model.getThemeColor,
              tabBarTheme: TabBarTheme(
                unselectedLabelColor: Colors.white,
                labelColor: Colors.white,
              ),
            ),
            routes: <String, WidgetBuilder>{'/': (BuildContext context) => RootPage()},
          );
        },
      ),
    );
  }
}
