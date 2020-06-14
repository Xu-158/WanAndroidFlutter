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
                          text: '注册',
                          fontColor: Colors.white,
                          fontSize: 20,
                          height: 45.px,
                        ),
                        Container(width: 10)
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
                              controller: registerViewModel.getUserNameC,
                              height: 40,
                              width: 230.px,
                              borderRadius: 10.0,
                              autoFocus: true,
                            ),
                            SizedBox(height: 10),
                            MyTextField(
                              controller: registerViewModel.getPassWord1C,
                              height: 40,
                              width: 230.px,
                              borderRadius: 10.0,
                              isPassword: true,
                            ),
                            SizedBox(height: 10),
                            MyTextField(
                              controller: registerViewModel.getPassWord2C,
                              height: 40,
                              width: 230.px,
                              borderRadius: 10.0,
                              isPassword: true,
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
                  width: winWidth * 0.7,
                  height: 40.px,
                  fontSize: 20,
                  text: '注册',
                ),
              ),
              onTap: ()=>registerViewModel.register(),
            )
          ],
        ),
      ),
    ));
  }
}
