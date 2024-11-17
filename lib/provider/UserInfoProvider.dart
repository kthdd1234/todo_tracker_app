import 'package:flutter/material.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';

class UserInfoProvider extends ChangeNotifier {
  UserInfoClass userInfo = initUserInfo;

  UserInfoClass get getUserInfo => userInfo;

  void changeUserInfo({required UserInfoClass newuUserInfo}) {
    userInfo = newuUserInfo;
    notifyListeners();
  }
}
