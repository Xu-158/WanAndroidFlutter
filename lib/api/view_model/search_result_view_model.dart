import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/search_model.dart';
import 'package:wanandroidflutter/page/search_result_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';

import '../api.dart';

class SearchResultViewModel extends BaseModel{
  List<SearchModel> _list = List();

  List<SearchModel> get getSearchResultList => _list;

  void getSearchResultData({@required key}) {
    if (reqStatus == ReqStatus.success) return;
    if(_list.isNotEmpty) _list.clear();
    Api.postSearch(key: key).then((value) {
      if (value == null) throw Exception('getHotSearchData is null');
      value['data']['datas'].map((e) {
        SearchModel m = SearchModel.fromJson(e);
        _list.add(m);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e){
      setState(ReqStatus.error);
    });
  }

  /// =============== Route =================
  void searchOnTap({key}) {
    NavigatorUtil.push(SearchResultPage(keys:key));
  }
}