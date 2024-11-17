import 'package:flutter/material.dart';
import 'package:todo_tracker_app/util/constants.dart';

class FontSizeProvider extends ChangeNotifier {
  double fintSize = defaultFontSize;

  setFontSize(double newFontSize) {
    fintSize = newFontSize;
    notifyListeners();
  }
}
