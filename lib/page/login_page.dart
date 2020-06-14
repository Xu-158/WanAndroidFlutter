import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/view_model/login_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/page/register_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/common/back_button.dart';
import 'package:wanandroidflutter/widget/common/small_widget.dart';
import 'package:wanandroidflutter/widget/common/text_field_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginViewModel viewModel = LoginViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        height: winHeight,
        child: Column(
          children: <Widget>[
            Container(
              width: winWidth,
              height: 300.px,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Card(
                color: themeColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        BackButton1(),
                        SmallWidget(
                          text: '登录',
                          fontColor: Colors.white,
                          fontSize: 22,
                          height: 45.px,
                        ),
                        InkWell(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.call_missed_outgoing,
                                color: Colors.white,
                              ),
                              SmallWidget(
                                text: '注册',
                                fontColor: Colors.white,
                                fontSize: 14,
                                height: 40.px,
                              ),
                            ],
                          ),
                          onTap: () {
                            NavigatorUtil.push(RegisterPage());
                          },
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SmallWidget(
                              text: '用户名:',
                              fontColor: Colors.white,
                              fontSize: 18,
                              height: 40.px,
                            ),
                            SmallWidget(
                              text: '密 码:',
                              fontColor: Colors.white,
                              fontSize: 18,
                              height: 40.px,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            MyTextField(
                              controller: viewModel.getUserNameC,
                              height: 40,
                              width: 230.px,
                              borderRadius: 10.0,
                              autoFocus: true,
                            ),
                            SizedBox(height: 10),
                            MyTextField(
                              controller: viewModel.getPassWordC,
                              height: 40,
                              width: 230.px,
                              borderRadius: 10.0,
                              isPassword: true,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              child: Card(
                child: SmallWidget(
                  bgColor: themeColor,
                  fontColor: Colors.white,
                  width: winWidth * 0.7,
                  height: 40.px,
                  fontSize: 20,
                  text: '登录',
                ),
              ),
              onTap: () => viewModel.login(),
            ),
          ],
        ),
      ),
    )));
  }
}
