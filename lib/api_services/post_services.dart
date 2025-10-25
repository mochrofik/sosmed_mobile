import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yure_connect_apps/constants/Globals.dart';

class PostServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "${Globals.urlApi}/posting",
      contentType: 'application/json',
    ),
  );

  Future<Response> myPost() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString(Globals.TOKEN_KEY);

    try {
      final response = await _dio.get(
        "/my-post",
        options: Options(
          headers: {"Authorization": token},
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        rethrow;
      }
      throw e.response?.data['message'] ?? 'Terjadi kesalahan saat login.';
    }
  }

  Future<Response> likePost(int postId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString(Globals.TOKEN_KEY);
    print("postId $postId");
    try {
      FormData formData = FormData.fromMap({
        "post_id": postId,
      });
      final response = await _dio.post(
        "/liked",
        data: formData,
        options: Options(
          headers: {"Authorization": token},
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        rethrow;
      }
      throw e.response?.data['message'] ?? 'Terjadi kesalahan saat login.';
    }
  }
}
