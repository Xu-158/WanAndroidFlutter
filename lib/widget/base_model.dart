import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/common/global.dart';

class BaseModel extends ChangeNotifier {
  ReqStatus reqStatus = ReqStatus.loading;

  ReqStatus get getReqStatus => reqStatus;

  void setState(ReqStatus status) {
    reqStatus = status;
    notifyListeners();
  }
}
