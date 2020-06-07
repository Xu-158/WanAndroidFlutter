import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/common/global.dart';

class BaseModel extends ChangeNotifier {
  ReqStatus reqStatus = ReqStatus.loading;

  ReqStatus get getReqStatus => reqStatus;

  bool disposed = false;

  void setState(ReqStatus status) {
    reqStatus = status;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }

  @override
  void notifyListeners() {
    if(!disposed){
      super.notifyListeners();
    }
  }
}
