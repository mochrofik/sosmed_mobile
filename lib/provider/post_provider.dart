import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yure_connect_apps/api_services/post_services.dart';
import 'package:yure_connect_apps/models/file_post_model.dart';
import 'package:yure_connect_apps/models/post_model.dart';
import 'package:yure_connect_apps/models/user_model.dart';

class PostProvider with ChangeNotifier {
  final PostServices postServices;

  final List<PostModel> _list = <PostModel>[];
  List<PostModel> get list => _list;

  final List<FilePostModel> _filePosts = [];
  List<FilePostModel> get filePosts => _filePosts;

  bool _isLoggedIn = true; // Contoh status
  bool get isLoggedIn => _isLoggedIn;

  PostProvider(this.postServices) {
    print("inisiasi post provider");
    mypost();
  }

  changeIndexImg(iPost, iImg) {
    _list[iPost].indexImg = iImg;
    notifyListeners();
  }

  Future<void> mypost() async {
    try {
      final response = await postServices.myPost();
      log("res $response");
      if (response.statusCode == 200) {
        _list.clear();
        notifyListeners();

        List res = response.data['data'];
        for (var element in res) {
          final user = element['user'];
          List files = element['upload_postings'];
          _filePosts.clear();

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
              ),
              likes: element['likes'],
              profile: user['profile'],
              createdAt: element['created_at'],
              updatedAt: element['updated_at'],
            ),
          );
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
}
