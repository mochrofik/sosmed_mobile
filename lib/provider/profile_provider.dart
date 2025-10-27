import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yure_connect_apps/api_services/post_services.dart';
import 'package:yure_connect_apps/api_services/profile_services.dart';
import 'package:yure_connect_apps/models/file_post_model.dart';
import 'package:yure_connect_apps/models/post_model.dart';
import 'package:yure_connect_apps/models/user_model.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileServices profileServices;

  PostServices postServices = PostServices();

  bool _isLoggedIn = true; // Contoh status
  bool get isLoggedIn => _isLoggedIn;

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  final List<PostModel> _list = <PostModel>[];
  List<PostModel> get list => _list;

  final List<FilePostModel> _filePosts = [];
  List<FilePostModel> get filePosts => _filePosts;

  ProfileProvider(this.profileServices) {
    myProfile();
    myPost();
  }

  Future<void> myPost() async {
    try {
      final response = await postServices.myPost();

      if (response.statusCode == 200) {
        print(response.data);
        _list.clear();
        notifyListeners();
        List res = response.data['data'] ?? [];
        for (var element in res) {
          final user = element['user'];
          List files = element['upload_postings'];
          _filePosts.clear();
          notifyListeners();

          List<FilePostModel> filesUp = [];
          for (var elem in files) {
            filesUp.add(
              FilePostModel(
                id: elem['ID'],
                fileUrl: elem['file_url'],
                format: elem['format'],
              ),
            );
          }

          _list.add(
            PostModel(
              id: element['ID'],
              indexImg: 0,
              posting: element['posting'],
              uploadPostings: filesUp,
              user: UserModel(
                  id: user['id'],
                  name: user['name'],
                  email: user['email'],
                  profile: user['profile'],
                  gender: user['gender'] ?? ""),
              likes: element['likes'],
              profile: user['profile'],
              createdAt: element['created_at'],
              updatedAt: element['updated_at'],
              isLiked: element['is_liked'],
            ),
          );
          notifyListeners();
        }
        notifyListeners();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _isLoggedIn = false;
      }
    }

    notifyListeners();
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
        notifyListeners();
      }
    }

    notifyListeners();
  }
}
