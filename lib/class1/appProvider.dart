import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int _count = 0;
  int get counterValue => _count;

  void incrementValue() {
    _count++;
    notifyListeners();
  }
}
