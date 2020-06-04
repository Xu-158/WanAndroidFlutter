import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier{

  LoginStatus loginStatus ;

  LoginStatus get getLoginStatus => this.loginStatus;

  set setLoginStatus(LoginStatus value){
    loginStatus = value;
    notifyListeners();
  }



}

enum LoginStatus{
  login,logout
}