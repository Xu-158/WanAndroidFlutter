import 'package:flutter/cupertino.dart';
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
      child: Column(
        children: <Widget>[
          Container(
            width: winWidth,
            height: 300.px,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      BackButton1(),
                      Text('登录', style: TextStyle(color: Colors.white, fontSize: 24)),
                      InkWell(
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.call_missed_outgoing,
                                size: 40,
                              ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: 45.px,
                              child: Text(
                                '用户名:',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Container(
                              height: 45.px,
                              alignment: Alignment.center,
                              child: Text(
                                '密  码:',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          MyTextField(
                            controller: viewModel.getUserNameC,
                            height: 40.px,
                            width: 230.px,
                            borderRadius: 10.0,
                            autoFocus: true,
                            hintText: '输入账号',
                          ),
                          SizedBox(height: 10),
                          MyTextField(
                            controller: viewModel.getPassWordC,
                            height: 40.px,
                            width: 230.px,
                            borderRadius: 10.0,
                            isPassword: true,
                            showSuffixIcon: true,
                            hintText: '输入密码',
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
                fontColor: Colors.white,
                width: winWidth * 0.9,
                fontSize: 20,
                text: '登录',
              ),
            ),
            onTap: () => viewModel.login(),
          ),
        ],
      ),
    )));
  }
}
