import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/widget/base/error_widget.dart';
import 'package:wanandroidflutter/widget/base/loading_widget.dart';

class BaseWidget extends StatelessWidget {
  final ReqStatus reqStatus;
  final Widget child;

  const BaseWidget({Key key, this.reqStatus, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (reqStatus == ReqStatus.error) {
      return ErrorWidgetPage();
    }
    if (reqStatus == ReqStatus.loading) {
      return LoadingWidget();
    } else {
      return child;
    }
  }
}

