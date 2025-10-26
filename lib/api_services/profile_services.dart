import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yure_connect_apps/constants/Globals.dart';

class ProfileServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Globals.urlApi,
      contentType: 'application/json',
    ),
  );

  getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString(Globals.TOKEN_KEY);
    return token!;
  }

  Future<Response> myProfile() async {
    try {
      final response = await _dio.get("/user/my-profile",
          options: Options(headers: {"Authorization": await getToken()}));
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Terjadi kesalahan saat login.';
    }
  }
}
