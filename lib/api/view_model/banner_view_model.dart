import 'package:wanandroidflutter/api/api.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/banner_model.dart';
import 'package:wanandroidflutter/page/web_view_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_model.dart';

class BannerViewModel extends BaseModel {
  List<BannerModel> bannerList = List();

  List<BannerModel> get getBannerList => bannerList;

  void getBannerData() {
    if (reqStatus == ReqStatus.success) return;
    Api.getBanner().then((value) {
      if (value['data'] == null) throw Exception('${value['errorMsg']}');
      value['data'].map((e) {
        BannerModel m = BannerModel.fromJson(e);
        bannerList.add(m);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e) {
      setState(ReqStatus.error);
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
