import 'dart:convert';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/user_model.dart';
import 'package:wanandroidflutter/page/login_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/util/sp_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

import '../api.dart';

class UserViewModel extends BaseModel {
  static UserModel user = UserModel();

  UserModel get getUser => user;

  UserStatus userStatus = UserStatus.logout;

  UserStatus get getUserStatus => userStatus;

  void initUser() {
    SPUtil.get(type: 'String', key: SPUtil.userInfo).then((value) {
      if (value != null && value != '') {
        user = UserModel.fromJson(jsonDecode(value));
        userStatus = UserStatus.login;
        setState(ReqStatus.success);
      }
    });
  }

  void goLogin() {
    NavigatorUtil.push(LoginPage()).then((value) {
      if (value != null && value != '') {
        user = UserModel.fromJson(value);
        userStatus = UserStatus.login;
        setState(ReqStatus.success);
      }
    });
  }

  void logout() {
    if (userStatus == UserStatus.logout) {
      return showToast(message: '您还未登录');
    }
    Api.logout().then((value) {
      SPUtil.remove(SPUtil.userInfo);
      userStatus = UserStatus.logout;
      user.admin = false;
      user.chapterTops = [];
      user.collectIds = [];
      user.email = '';
      user.icon = '';
      user.id = 0;
      user.nickname = '';
      user.password = '';
      user.publicName = '';
      user.token = '';
      user.type = 0;
      user.username = '';
      showToast(message: '退出成功');
      setState(ReqStatus.success);
    });
  }
}
