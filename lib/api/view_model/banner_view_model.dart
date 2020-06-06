import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/api/model/banner_model.dart';
import 'package:wanandroidflutter/common/global.dart';

class BannerViewModel extends ChangeNotifier {
  int count = 0;

  int get getCount => count;

  void add(){
    this.count++;
    notifyListeners();
  }


  BannerViewModel(this.count);


  List<BannerModel> list = List();

  List<BannerModel> get getList => list;

  ReqStatus status = ReqStatus.loading;

  ReqStatus get getStatus => status;

  void getBannerData1(){
    BannerRequestModel().getBanner1().then((value){
      if (value['errorCode'] == 0) {
        value['data'].map((e) {
          BannerModel m = BannerModel.fromJson(e);
          list.add(m);
        }).toList();
        this.status = ReqStatus.success;
        print("this $status");
        notifyListeners();
      }
    });
  }

  void getBannerData() => BannerRequestModel().getBanner().listen((res) {
        //    state 判断是否请求成功 更改状态
        if (res['errorCode'] == 0) {
          res['data'].map((e) {
            BannerModel m = BannerModel.fromJson(e);
            list.add(m);
          }).toList();
          print("success----${list[0].imagePath}");
          status = ReqStatus.success;
          print("this $status");
          Future.delayed(Duration(seconds: 1), () {
            notifyListeners();
          });
        }
      }, onDone: () {
        notifyListeners();
      }, onError: (_) {
        status = ReqStatus.error;
        notifyListeners();
      });
}
