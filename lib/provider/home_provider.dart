import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int _currentBottomNavigate = 0;
  int get currentBottomNavigate => _currentBottomNavigate;

  void currentNavigate(i) {
    _currentBottomNavigate = i;
    notifyListeners();
  }
}
