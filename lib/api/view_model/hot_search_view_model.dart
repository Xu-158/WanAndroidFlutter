import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/api.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/hot_search_model.dart';
import 'package:wanandroidflutter/page/search_result_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

class HotSearchViewModel extends BaseModel {
  List<HotSearchModel> _list = List();

  TextEditingController _controller = TextEditingController();

  List<HotSearchModel> get getHotSearchList => _list;

  TextEditingController get getTextController => _controller;


  void getHotSearchData() {
    if (reqStatus == ReqStatus.success) return;
    Api.getHotSearch().then((value) {
      if (value == null) throw Exception('getHotSearchData is null');
      value['data'].map((e) {
        HotSearchModel m = HotSearchModel.fromJson(e);
        _list.add(m);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e){
      setState(ReqStatus.error);
    });
  }

  /// =============== Route =================
  void searchOnTap({String key}) {
    if(key.isEmpty&&key==''){
      showToast(message: '搜索内容为空');
      return;
    }
    NavigatorUtil.push(SearchResultPage(keys:key));
  }
}
