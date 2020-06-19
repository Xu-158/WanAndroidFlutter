import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/user_integral_model.dart';
import 'package:wanandroidflutter/model/user_model.dart';
import 'package:wanandroidflutter/page/collect_page.dart';
import 'package:wanandroidflutter/page/login_page.dart';
import 'package:wanandroidflutter/root_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/util/sp_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

import '../api.dart';

class UserViewModel extends BaseModel {
  UserModel user = UserModel();
  UserModel get getUser => user;

  UserStatus userStatus = UserStatus.logout;
  UserStatus get getUserStatus => userStatus;

  UserIntegralModel userIntegralModel = UserIntegralModel();
  UserIntegralModel get getUserIntegral => userIntegralModel;

  TextEditingController controller = TextEditingController();
  TextEditingController get getController => controller;

  String qqAvatarUrl = '';
  String get getQQAvatarUrl => qqAvatarUrl;

  void initUser() {
    SPUtil.get(type: String, key: SPUtil.userInfo).then((value) {
      if (value != null && value != '') {
        user = UserModel.fromJson(jsonDecode(value));
        userStatus = UserStatus.login;
        SPUtil.get(type: String, key: SPUtil.qqAvatarUrl)
            .then((value) => qqAvatarUrl = value ?? '');
        setState(ReqStatus.success);
      }
    });
    Api.getUserIntegral().then((value) {
      if (value == null) throw Exception('getUserIntegral is null');
      userIntegralModel = UserIntegralModel.fromJson(value['data']);
      setState(ReqStatus.success);
    }).catchError((e) {
      setState(ReqStatus.error);
    });
  }

  void goLogin() {
    NavigatorUtil.push(LoginPage());
  }

  void getQQAvatar() {
    qqAvatarUrl = controller.text;
    qqAvatarUrl = 'http://q1.qlogo.cn/g?b=qq&nk=$qqAvatarUrl&s=640';
    print("url::::$qqAvatarUrl");
    SPUtil.setData(type: String, key: SPUtil.qqAvatarUrl, value: qqAvatarUrl);
    setState(ReqStatus.success);
    NavigatorUtil.maybePop();
  }

  void logout() {
    if (userStatus == UserStatus.logout) {
      NavigatorUtil.maybePop();
      return showToast(message: '您还未登录');
    }
    Api.logout().then((value) {
      SPUtil.remove(SPUtil.userInfo);
      SPUtil.remove(SPUtil.qqAvatarUrl);
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
      userIntegralModel.coinCount = 0;
      showToast(message: '退出成功');
      setState(ReqStatus.success);
      NavigatorUtil.pushAndRemoveUntil(RootPage());
    }).catchError((e) {
      showToast(message: '退出失败');
    });
  }

  /// =============== Route =================
  void push({@required title}) {
    switch (title) {
      case '收藏':
        NavigatorUtil.push(CollectPage());
        break;
    }
  }
}
