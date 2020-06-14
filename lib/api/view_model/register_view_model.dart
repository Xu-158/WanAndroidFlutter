import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/api.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

class RegisterViewModel extends BaseModel {
  TextEditingController userNameC = TextEditingController();
  TextEditingController passWord1C = TextEditingController();
  TextEditingController passWord2C = TextEditingController();

  TextEditingController get getUserNameC => userNameC;
  TextEditingController get getPassWord1C => passWord1C;
  TextEditingController get getPassWord2C => passWord2C;

  void register() {
    Api.register(
            username: userNameC.text,
            password: passWord1C.text,
            repassword: passWord2C.text)
        .then((value) {
      if (value['errorCode'] == -1)
        return showToast(message: '${value['errorMsg']}');
      if (value['errorCode'] == 0) {
        showToast(message: '注册成功');
        return NavigatorUtil.maybePop();
      }
    });
  }
}
