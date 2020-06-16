import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/search_model.dart';
import 'package:wanandroidflutter/page/web_view_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';

import '../api.dart';

class SearchResultViewModel extends BaseModel {
  List<SearchModel> _list = List();

  EasyRefreshController _easyRefreshController = EasyRefreshController();

  String thisKey;

  int totalPage = 1;

  int currentPage = 0;

  List<SearchModel> get getSearchResultList => _list;

  EasyRefreshController get getEasyRefreshController => _easyRefreshController;

  void getSearchResultData({@required key, page = 0}) {
    thisKey = key;
    Api.postSearch(key: key, page: page).then((value) {
      if (value == null) throw Exception('getHotSearchData is null');
      totalPage = ((value['data']['total']) / 20).round();
      value['data']['datas'].map((e) {
        SearchModel m = SearchModel.fromJson(e);
        _list.add(m);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e) {
      setState(ReqStatus.error);
    });
  }

  Future<void> onRefresh() {
    _list.clear();
    currentPage = 0;
    getSearchResultData(key: thisKey, page: currentPage);
    _easyRefreshController.finishLoad();
    return Future.value();
  }

  Future<void> onLoad() {
    if (currentPage < totalPage) {
      currentPage++;
      getSearchResultData(key: thisKey, page: currentPage);
    }
    return Future.value();
  }

  /// =============== Route =================
  void searchResultOnTap({url, title}) {
    NavigatorUtil.push(WebViewPage(
      openUrl: url,
      title: title,
      isHtml: true,
    ));
  }
}
