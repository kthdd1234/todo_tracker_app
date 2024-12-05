import 'package:flutter/material.dart';
import 'package:todo_tracker_app/util/class.dart';

class GroupInfoListProvider extends ChangeNotifier {
  List<GroupInfoClass> groupInfoList = [];

  List<GroupInfoClass> get getGroupInfoList => groupInfoList;

  void changeGroupInfoList({required newGroupInfoList}) {
    groupInfoList = newGroupInfoList;
    notifyListeners();
  }
}
