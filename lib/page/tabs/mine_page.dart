import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:wanandroidflutter/api/view_model/user_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/widget/base/base_Page.dart';
import 'package:wanandroidflutter/widget/common/row_tile_widget.dart';
import 'package:wanandroidflutter/widget/common/small_widget.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  UserViewModel userViewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: BasePage<UserViewModel>(
            viewModel: userViewModel,
            onFirstLoading: (v) {
              v.initUser();
            },
            builder: (context, model, child) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: winWidth,
                      height: 200.px,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Card(
                        color: themeColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Visibility(
                              visible: model.getUserStatus == UserStatus.logout,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    child: Text(
                                      '请先登录您的账号',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  InkWell(
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.call_missed_outgoing,
                                          color: Colors.white,
                                        ),
                                        SmallWidget(
                                          text: '去登陆',
                                          fontColor: Colors.white,
                                          fontSize: 14,
                                          height: 40.px,
                                        ),
                                      ],
                                    ),
                                    onTap: () => model.goLogin(),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: model.getUserStatus == UserStatus.login,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    ' ${model.getUser.nickname}',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    RowTileWidget(
                      title: '退出登录',
                      onTap: () => model.logout(),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
