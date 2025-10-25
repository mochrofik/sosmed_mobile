import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
              ),
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

  Future<void> likePost(int postId) async {
    try {
      final response = await postServices.likePost(postId);
      if (response.statusCode == 201) {
        await mypost();
      }
      notifyListeners();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _isLoggedIn = false;
      }
    }
    notifyListeners();
  }

  File? _imageFile;

  File? get imageFile => _imageFile;

  // Instance dari ImagePicker
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      // Panggil method pickImage/pickVideo/pickMedia
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1800, // Opsional: batasi resolusi
        maxHeight: 1800,
      );

      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      // Handle error (misalnya izin ditolak)
      print("Error saat memilih gambar: $e");
    }
  }
}
