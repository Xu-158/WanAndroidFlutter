import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/api/api.dart';
import 'package:wanandroidflutter/api/view_model/user_view_model.dart';
import 'package:wanandroidflutter/root_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/util/sp_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

class LoginViewModel extends BaseModel {
  TextEditingController userNameC = TextEditingController();
  TextEditingController passWordC = TextEditingController();

  TextEditingController get getUserNameC => userNameC;
  TextEditingController get getPassWordC => passWordC;

  void login() {
    Api.login(username: userNameC.text, password: passWordC.text).then((value) {
      if (value['errorCode'] == -1) return showToast(message: '${value['errorMsg']}');
      if (value['errorCode'] == 0) {
        showToast(message: '登录成功');
        SPUtil.setData(type: 'String', key: SPUtil.userInfo, value: json.encode(value['data']));
        UserViewModel().initUser();
        NavigatorUtil.pushAndRemoveUntil(RootPage());
      }
    });
  }
}
