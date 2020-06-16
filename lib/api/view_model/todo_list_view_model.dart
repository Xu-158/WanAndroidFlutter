import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroidflutter/api/api.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/todo_list_model.dart';
import 'package:wanandroidflutter/page/tabs/edit_todo_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

class TodoListViewModel extends BaseModel {
  List<TodoListModel> _list = List<TodoListModel>();
  List<TodoListModel> get getTodoList => _list;

  EasyRefreshController _easyRefreshController = EasyRefreshController();
  EasyRefreshController get getEasyRefreshController => _easyRefreshController;

  int _totalPage = 1;
  int _currentPage = 0;

  void getToDoListData({page = 1}) {
    Api.getTodoList(page: page).then((value) {
      if (value['data'] == null) throw Exception('${value['errorMsg']}');
      _totalPage = ((value['data']['total']) / 20).round();
      value['data']['datas'].map((v) {
        TodoListModel m = TodoListModel.fromJson(v);
        _list.add(m);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e) {
      showToast(message: e.toString());
      setState(ReqStatus.error);
    });
  }

  void changeStatusTodo({todoId, status}) {
    int thisStatus;
    status == 1 ? thisStatus = 0 : thisStatus = 1;
    Api.changeStatusTodo(todoId: todoId, status: thisStatus).then((value) {
      if (value['data'] == null) throw Exception('${value['errorMsg']}');
      TodoListModel m = TodoListModel.fromJson(value['data']);
      if (m.status == 1) {
        showToast(message: '已完成');
      } else {
        showToast(message: '未完成');
      }
      setState(ReqStatus.success);
    }).catchError((e) {
      showToast(message: e.toString());
      setState(ReqStatus.error);
    });
  }

  void deleteTodo({todoId, index}) {
    Api.deleteTodo(todoId: todoId).then((value) {
      if (value == null) throw Exception('${value['errorMsg']}');
      if (value['errorCode'] == 0) {
        _list.removeAt(index);
        showToast(message: '删除成功');
      }
      setState(ReqStatus.success);
    }).catchError((e) {
      showToast(message: '删除失败');
      setState(ReqStatus.error);
    });
  }

  Future<void> onRefresh() {
    _list.clear();
    _currentPage = 0;
    getToDoListData(page: 0);
    _easyRefreshController.finishLoad();
    return Future.value();
  }

  Future<void> onLoad() {
    if (_currentPage < _totalPage) {
      _currentPage++;
      getToDoListData(page: _currentPage);
    }
    return Future.value();
  }

  void doEdit({todoId, title, content,isUpdate = false}) {
    NavigatorUtil.push(EditTodoPage(
      title: title,
      content: content,
      todoId: todoId,
      isUpdate: isUpdate,
    )).then((value) {
      if (value == 'success') {
        onRefresh();
      }
    });
  }
}
