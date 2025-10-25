import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeProvider with ChangeNotifier {
  int _currentBottomNavigate = 0;
  int get currentBottomNavigate => _currentBottomNavigate;

  void currentNavigate(i) {
    _currentBottomNavigate = i;

    notifyListeners();
  }
}
