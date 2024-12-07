import 'package:flutter/material.dart';

class SelectedDateTimeProvider extends ChangeNotifier {
  DateTime selectedDateTime = DateTime.now();

  void changeSelectedDateTime({required DateTime dateTime}) {
    selectedDateTime = dateTime;
    notifyListeners();
  }
}
