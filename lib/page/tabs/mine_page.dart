import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:wanandroidflutter/api/view_model/user_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_Page.dart';
import 'package:wanandroidflutter/widget/common/ios_dialog_widget.dart';
import 'package:wanandroidflutter/widget/common/row_tile_widget.dart';
import 'package:wanandroidflutter/widget/common/text_field_widget.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Card(
                      color: themeColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      elevation: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                            visible: model.getUserStatus == UserStatus.logout,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  child: Text(
                                    '请先登录您的账号',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                InkWell(
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.call_missed_outgoing,
                                      color: themeColor,
                                      size: 40,
                                    ),
                                  ),
                                  onTap: () => model.goLogin(),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: model.getUserStatus == UserStatus.login,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration:
                                        BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                    child: model.getQQAvatarUrl == ''
                                        ? FlutterLogo(size: 70)
                                        : ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: model.getQQAvatarUrl,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                  onTap: () {
                                    showIosDialogWidget(context,
                                        title: 'QQ号码',
                                        subWidget: MyTextField(
                                          controller: model.getController,
                                          height: 35.px,
                                          width: 230.px,
                                          borderRadius: 10.0,
                                          hintText: '请输入QQ号码',
                                        ),
                                        onCancelTap: () => NavigatorUtil.maybePop(),
                                        onOkTap: () => userViewModel.getQQAvatar());
                                  },
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white, shape: BoxShape.circle),
                                          padding: EdgeInsets.all(4),
                                          margin: EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.android,
                                            color: Colors.green,
                                            size: 18,
                                          ),
                                        ),
                                        Text(
                                          '${model?.getUser?.nickname}',
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'id: ${model?.getUser?.id}',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      model.getReqStatus == ReqStatus.error
                                          ? '积分:获取失败'
                                          : '积分: ${model?.getUserIntegral?.coinCount ?? 0}',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RowTileWidget(
                    icon: Icon(
                      Icons.list,
                      color: Colors.green,
                    ),
                    title: 'TODO',
                    onTap: () {},
                  ),
                  RowTileWidget(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    title: '收藏',
                    onTap: () => model.push(title: '收藏'),
                  ),
                  RowTileWidget(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.blue,
                    ),
                    title: '设置',
                    onTap: () {},
                  ),
                  RowTileWidget(
                    icon: Icon(
                      Icons.color_lens,
                      color: Colors.orange,
                    ),
                    title: '换肤',
                    onTap: () {},
                  ),
                  RowTileWidget(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black87,
                    ),
                    title: '退出',
                    onTap: () {
                      showIosDialogWidget(context,
                          title: '确定退出吗？',
                          subTitle: '',
                          onCancelTap: () => NavigatorUtil.maybePop(),
                          onOkTap: () => userViewModel.logout());
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
