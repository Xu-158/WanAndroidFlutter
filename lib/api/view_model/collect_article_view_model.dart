import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroidflutter/api/api.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/collect_articles_model.dart';
import 'package:wanandroidflutter/page/web_view_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';
import 'package:wanandroidflutter/widget/common/toast.dart';

class CollectArticleViewModel extends BaseModel {
  List<CollectArticlesModel> _list = List<CollectArticlesModel>();
  List<CollectArticlesModel> get getCollectArticleList => _list;

  EasyRefreshController _easyRefreshController = EasyRefreshController();
  EasyRefreshController get getEasyRefreshController => _easyRefreshController;

  int totalPage = 1;
  int currentPage = 0;

  void getCollectArticleListData({page = 0}) {
    Api.getCollectArticleList(page: page).then((value) {
      if (value['data'] == null) throw Exception('${value['errorMsg']}');
      totalPage = ((value['data']['total']) / 20).round();
      value['data']['datas'].map((m) {
        CollectArticlesModel collectArticlesModel = CollectArticlesModel.fromJson(m);
        _list.add(collectArticlesModel);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e){
      showToast(message: e.toString());
      setState(ReqStatus.error);
    });
  }

  Future<void> onRefresh() {
    _list.clear();
    currentPage = 0;
    getCollectArticleListData(page: 0);
    _easyRefreshController.finishLoad();
    return Future.value();
  }

  Future<void> onLoad() {
    if (currentPage < totalPage) {
      currentPage++;
      getCollectArticleListData(page: currentPage);
    }
    return Future.value();
  }

  void doCollect({@required articleId}) {
    print('收藏操作');
    setState(ReqStatus.success);
    Api.doCollectArticle(articleId: articleId).then((value) {
      if (value['errorCode'] == 0) {
        showToast(message: '收藏成功');
      } else {
        showToast(message: '收藏失败');
      }
    });
  }

  void unCollectByHome({@required articleId}) {
    print('取消收藏操作');
    setState(ReqStatus.success);
    Api.unCollectArticleByHome(articleId: articleId).then((value) {
      if (value['errorCode'] == 0) {
        showToast(message: '取消成功');
      } else {
        showToast(message: '取消失败');
      }
    });
  }

  void unCollectByMine({@required articleId, originId = -1, index = 0}) {
    Api.unCollectArticleByMine(articleId: articleId, originId: originId).then((value) {
      if (value['errorCode'] == 0) {
        setState(ReqStatus.success);
        _list.removeAt(index);
        showToast(message: '取消成功');
      } else {
        showToast(message: '取消失败');
      }
    });
  }

  /// =============== Route =================
  void cardOnTap({url, title}) {
    NavigatorUtil.push(WebViewPage(
      openUrl: url,
      title: title,
    ));
  }
}
