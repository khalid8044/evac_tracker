import 'package:flutter/material.dart';

class ComplaintCountProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void updateCount(int newCount) {
    _count = newCount;
    notifyListeners();
  }
}
