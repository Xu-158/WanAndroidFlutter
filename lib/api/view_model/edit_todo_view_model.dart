import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/api.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

class EditTodoViewModel extends BaseModel {
  TextEditingController titleC = TextEditingController();
  TextEditingController contentC = TextEditingController();

  TextEditingController get getTitleC => titleC;
  TextEditingController get getContentC => contentC;

  void release() {
    Api.addTodo(title: titleC.text, content: contentC.text, date: null).then((value) {
      if (value['errorCode'] == 0) {
        showToast(message: '添加成功');
        NavigatorUtil.maybePop('success');
      } else {
        showToast(message: '${value['errorMsg']}');
      }
    }).catchError((e) {
      showToast(message: '失败');
    });
  }

  void updateTodo({todoId, date}) {
    Api.updateTodo(todoId: todoId, title: titleC.text, content: contentC.text, date: date)
        .then((value) {
      if (value['errorCode'] == 0) {
        showToast(message: '修改成功');
        NavigatorUtil.maybePop('success');
      } else {
        showToast(message: '${value['errorMsg']}');
      }
    }).catchError((e) {
      showToast(message: '失败');
    });
  }
}
