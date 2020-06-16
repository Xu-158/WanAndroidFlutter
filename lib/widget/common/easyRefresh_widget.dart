import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroidflutter/common/global.dart';

class RefreshWidget extends StatelessWidget {
  final EasyRefreshController controller;

  final OnRefreshCallback onRefresh;

  final OnLoadCallback onLoad;

  final Widget child;

  final Footer footer;

  final Header header;

  RefreshWidget({
    this.controller,
    this.onRefresh,
    this.onLoad,
    this.header,
    this.footer,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: controller,
      header: ClassicalHeader(
          infoColor: themeColor,
          textColor: themeColor,
          refreshedText: 'OK',
          refreshReadyText: '刷新',
          refreshText: '下拉刷新'),
      footer: ClassicalFooter(
          textColor: themeColor,
          infoColor: themeColor,
          noMoreText: '没有更多了',
          loadReadyText: '正在加载',
          loadedText: '加载更多'),
      onRefresh: onRefresh,
      onLoad: onLoad,
      child: child,
    );
  }
}
