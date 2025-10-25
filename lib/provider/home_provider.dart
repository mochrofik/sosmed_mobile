import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeProvider with ChangeNotifier {
  int _currentBottomNavigate = 0;
  int get currentBottomNavigate => _currentBottomNavigate;

  File? _imageFile;

  File? get imageFile => _imageFile;

  // Instance dari ImagePicker
  final ImagePicker _picker = ImagePicker();

  void currentNavigate(i) {
    _currentBottomNavigate = i;

    if (i == 1) {
      print("kamera");
      _pickImage(ImageSource.gallery);
    }
    notifyListeners();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      // Panggil method pickImage/pickVideo/pickMedia
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1800, // Opsional: batasi resolusi
        maxHeight: 1800,
      );
    } catch (e) {
      // Handle error (misalnya izin ditolak)
      print("Error saat memilih gambar: $e");
    }
  }
}
