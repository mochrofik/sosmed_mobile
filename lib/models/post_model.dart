import 'package:yure_connect_apps/models/file_post_model.dart';
import 'package:yure_connect_apps/models/user_model.dart';

class PostModel {
  final int id;
  int indexImg;
  final UserModel user;
  final String posting;
  final List<FilePostModel> uploadPostings;
  final String createdAt;
  final String updatedAt;
  final String profile;
  int likes;

  PostModel(
      {required this.indexImg,
      required this.id,
      required this.user,
      required this.posting,
      required this.uploadPostings,
      required this.createdAt,
      required this.updatedAt,
      required this.profile,
      required this.likes});
}
