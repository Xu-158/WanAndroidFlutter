import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/api.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/hot_search_model.dart';
import 'package:wanandroidflutter/page/search_result_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/util/sp_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

class HotSearchViewModel extends BaseModel {
  List<HotSearchModel> _list = List();

  List<String> _historySearchList = List();

  TextEditingController _controller = TextEditingController();

  List<HotSearchModel> get getHotSearchList => _list;

  List<String> get getHistorySearchList => _historySearchList;

  TextEditingController get getTextController => _controller;

  void getHotSearchData() async {
    _historySearchList =
        await SPUtil.get(type: List, key: SPUtil.historySearch) ?? [];
    if (reqStatus == ReqStatus.success) return;
    Api.getHotSearch().then((value) {
      if (value['data'] == null) throw Exception('${value['errorMsg']}');
      value['data'].map((e) {
        HotSearchModel m = HotSearchModel.fromJson(e);
        _list.add(m);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e) {
      setState(ReqStatus.error);
    });
  }

  void clearHistorySearch() {
    SPUtil.remove(SPUtil.historySearch);
    _historySearchList.clear();
    notifyListeners();
  }

  /// =============== Route =================
  void searchOnTap({String key}) {
    if (key.isEmpty && key == '') {
      showToast(message: '搜索内容为空');
      return;
    }
    if (_historySearchList.isNotEmpty && _historySearchList[0] == key) {
      _historySearchList.removeAt(0);
    }
    _historySearchList.insert(0, key);
    SPUtil.setData(
        type: List, key: SPUtil.historySearch, value: _historySearchList);
    Future.delayed(Duration(milliseconds: 200), () {
      setState(ReqStatus.success);
    });
    NavigatorUtil.push(SearchResultPage(keys: key));
  }
}
