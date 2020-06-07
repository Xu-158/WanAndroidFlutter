import 'package:wanandroidflutter/api/model/banner_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/widget/base_model.dart';

class BannerViewModel extends BaseModel {
  List<BannerModel> list = List();

  List<BannerModel> get getList => list;

  void getBannerData() => BannerRequestModel().getBanner().listen((res) {
        //    state 判断是否请求成功 更改状态
        if (res['errorCode'] == 0) {
          res['data'].map((e) {
            BannerModel m = BannerModel.fromJson(e);
            list.add(m);
          }).toList();
          setState(ReqStatus.success);
        }
      }, onDone: () {
//        完成后
      }, onError: (_) {
        setState(ReqStatus.error);
      });
}
