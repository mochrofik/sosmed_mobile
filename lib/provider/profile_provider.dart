import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yure_connect_apps/api_services/profile_services.dart';
import 'package:yure_connect_apps/models/user_model.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileServices profileServices;

  bool _isLoggedIn = true; // Contoh status
  bool get isLoggedIn => _isLoggedIn;

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  ProfileProvider(this.profileServices) {
    myProfile();
  }

  Future<void> myProfile() async {
    try {
      final response = await profileServices.myProfile();

      if (response.statusCode == 200) {
        print(response.data);

        if (response.data['data'] != null) {
          final data = response.data['data'];

          _userModel = UserModel(
            id: data['id'],
            name: data['name'],
            email: data['email'],
            profile: data['profile'],
            gender: data['gender'],
          );
          notifyListeners();
        }
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _isLoggedIn = false;
      }
    }

    notifyListeners();
  }
}
