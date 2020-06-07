import 'package:wanandroidflutter/api/api.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/banner_model.dart';
import 'package:wanandroidflutter/model/home_article_model.dart';
import 'package:wanandroidflutter/widget/base_model.dart';

class HomeViewModel extends BaseModel {
  List<BannerModel> bannerList = List();

  List<HomeArticleModel> articleList = List();

  List<BannerModel> get getBannerList => bannerList;

  List<HomeArticleModel> get getArticleList => articleList;

  void getHomeArticleData() {
    Api.getHomeArticleList().then((value){
      if (value['errorCode'] == 0) {
        value['data']['datas'].map((m) {
          HomeArticleModel model = HomeArticleModel.fromJson(m);
          articleList.add(model);
        }).toList();
        setState(ReqStatus.success);
      }
    });
//    catchError((e){
//      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${e.toString()}");
//    });
  }

//  void getHomeArticleData() {
//    Api.getHomeArticleList().listen((value) {
//      if (value['errorCode'] == 0) {
//        value['data'].map((m) {
//          HomeArticleModel model = HomeArticleModel.fromJson(m);
//          articleList.add(model);
//        }).toList();
//        setState(ReqStatus.success);
//      }
//    }, onError: () {
//      setState(ReqStatus.error);
//    });
//  }

  void getBannerData() {
    Api.getBanner().listen((res) {
      if (res['errorCode'] == 0) {
        res['data'].map((e) {
          BannerModel m = BannerModel.fromJson(e);
          bannerList.add(m);
        }).toList();
        setState(ReqStatus.success);
      }
    }, onDone: () {
//        完成后
      print("完成了！！！！！");
    }, onError: (_) {
      setState(ReqStatus.error);
    });
  }
}
