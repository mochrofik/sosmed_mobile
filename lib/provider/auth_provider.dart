import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yure_connect_apps/api_services/auth_services.dart';
import 'package:yure_connect_apps/constants/Globals.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices authService;
  

  final SharedPreferences _prefs;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isCheckingAuth = false;
  bool get isCheckingAuth => _isCheckingAuth;

  bool _isObscureText = true;

  bool get isObscureText => _isObscureText;

  bool _isObscureTextConfirm = true;
  bool get isObscureTextConfirm => _isObscureTextConfirm;

  String? _valueGender;
  String? get valueGender => _valueGender;

  String? _statusResponse;
  String? get statusResponse => _statusResponse;

  AuthProvider(this.authService, this._prefs) {
    // Cek status login saat AuthProvider diinisialisasi
    print("inisialisasi auth provider");
    _checkLoginStatus();
  }

  void obscureText() {
    _isObscureText = !_isObscureText;
    notifyListeners();
  }

  void obscureTextConfirm() {
    _isObscureTextConfirm = !_isObscureTextConfirm;
    notifyListeners();
  }

  void _checkLoginStatus() async {
    _isCheckingAuth = true;
    final token = _prefs.getString('authToken');
    await Future.delayed(const Duration(seconds: 5)); // Simulasi waktu loading

    _isLoggedIn = token != null;
    _isCheckingAuth = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;

    _prefs.clear();
    _isLoading = false;
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await authService.login(email, password);

      if (response.statusCode == 200) {
        if (response.data != null) {
          final token = response.data['data']['token'];

          print("token $token");

          if (token != null) {
            await _prefs.setString(Globals.TOKEN_KEY, token);
            _isLoggedIn = true;
          } else {
            _errorMessage = 'Login Gagal: Token tidak diterima.';
          }
        } else {
          _errorMessage =
              response.data['data']['message'] ?? response.statusMessage;
        }
      } else {
        _errorMessage = response.statusMessage;
      }
    } catch (error) {
      _errorMessage = error.toString();
      _isLoggedIn = false;
    } finally {
      _isLoading = false;
      notifyListeners(); // Beri tahu UI untuk update
    }
  }

  void changeGender(String value) {
    _valueGender = value;
    notifyListeners();
  }

  void setNull() {
    _valueGender = null;
    notifyListeners();
  }

  Future<void> register(
      TextEditingController name,
      TextEditingController email,
      String gender,
      TextEditingController password,
      TextEditingController passwordconfirm) async {
    _isLoading = true;
    _errorMessage = null;
    _statusResponse = null;
    notifyListeners();

    print(name.text + email.text);
    print(gender + password.text);

    try {
      final response = await authService.register(
          name: name.text.toString(),
          email: email.text.toString(),
          gender: gender.toLowerCase(),
          password: password.text.toString(),
          passwordconfirm: passwordconfirm.text.toString());

      print(response);

      _statusResponse = response.statusCode.toString();
      if (response.statusCode != 201) {
        _errorMessage = response.statusMessage;
      } else {
        name.clear();
        email.clear();
        password.clear();
        passwordconfirm.clear();
      }
    } catch (e) {
      _statusResponse = "500";
      _errorMessage = e.toString();
      print(e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }
}
