import 'package:dio/dio.dart';
import 'package:yure_connect_apps/constants/Globals.dart';

class AuthServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Globals.urlApi,
      contentType: 'application/json',
    ),
  );

  Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Terjadi kesalahan saat login.';
    }
  }

  Future<Response> register(
      {required String name,
      required String email,
      required String gender,
      required String password,
      required String passwordconfirm}) async {
    try {
      final response = await _dio.post(
        "/register",
        data: {
          "name": name,
          "email": email,
          "gender": gender,
          "password": password,
          "password_confirm": passwordconfirm,
        },
      );
      return response;
    } on DioException catch (e) {
      print("dio ${e.toString()}");
      print("dio message ${e.message.toString()}");
      print("dio response ${e.response.toString()}");
      throw e.response?.data['message'] ?? 'Terjadi kesalahan saat login.';
    }
  }
}
