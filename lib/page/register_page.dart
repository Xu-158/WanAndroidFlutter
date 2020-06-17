import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wanandroidflutter/api/view_model/register_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/widget/common/back_button.dart';
import 'package:wanandroidflutter/widget/common/small_widget.dart';
import 'package:wanandroidflutter/widget/common/text_field_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterViewModel registerViewModel = RegisterViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: winWidth,
              height: 300.px,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Card(
                color: themeColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(fit: FlexFit.tight, flex: 1, child: BackButton1()),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: SmallWidget(
                            text: '注册',
                            fontColor: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Flexible(fit: FlexFit.tight, flex: 1, child: Container())
                      ],
                    ),
                    Row(
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            MyTextField(
                              controller: registerViewModel.getUserNameC,
                              height: 40.px,
                              width: 230.px,
                              borderRadius: 10.0,
                              autoFocus: true,
                              hintText: '支持数字，中文',
                            ),
                            SizedBox(height: 10),
                            MyTextField(
                              controller: registerViewModel.getPassWord1C,
                              height: 40.px,
                              width: 230.px,
                              borderRadius: 10.0,
                              isPassword: true,
                              showSuffixIcon: true,
                              hintText: '输入密码',
                            ),
                            SizedBox(height: 10),
                            MyTextField(
                              controller: registerViewModel.getPassWord2C,
                              height: 40.px,
                              width: 230.px,
                              borderRadius: 10.0,
                              isPassword: true,
                              showSuffixIcon: true,
                              hintText: '再次输入密码',
                            ),
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
                  width: winWidth * 0.9,
                  fontSize: 20,
                  text: '注册',
                ),
              ),
              onTap: () => registerViewModel.register(),
            )
          ],
        ),
      ),
    ));
  }
}
