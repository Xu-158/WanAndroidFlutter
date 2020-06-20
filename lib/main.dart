import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/root_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/util/path_util.dart';
import 'package:wanandroidflutter/util/sp_util.dart';
import 'package:wanandroidflutter/widget/base/base_Page.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';

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
  AppTheme model = AppTheme();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppTheme()),
      ],
      child: BasePage<AppTheme>(
        viewModel: model,
        onFirstLoading: (v) {
          SPUtil.get(type: String, key: SPUtil.themeColor, defaultValue: 'cyan')
              .then((value) => model.setThemeColor(value));
        },
        builder: (context, model, child) {
          return MaterialApp(
            title: 'FlutterWanAndroid',
            navigatorKey: NavigatorUtil.navKey,
            theme: ThemeData(
              cupertinoOverrideTheme: CupertinoThemeData(
                primaryColor: model.getThemeColor,
                primaryContrastingColor: model.getThemeColor,
                barBackgroundColor: model.getThemeColor,
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
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => RootPage()
            },
          );
        },
      ),
    );
  }
}
