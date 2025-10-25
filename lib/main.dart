import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yure_connect_apps/api_services/auth_services.dart';
import 'package:yure_connect_apps/api_services/post_services.dart';
import 'package:yure_connect_apps/provider/auth_provider.dart';
import 'package:yure_connect_apps/provider/home_provider.dart';
import 'package:yure_connect_apps/provider/post_provider.dart';
import 'package:yure_connect_apps/utils/GlobalFunctions.dart';
import 'package:yure_connect_apps/views/auth/login.dart';
import 'package:yure_connect_apps/views/auth/splashscreen.dart';
import 'package:yure_connect_apps/views/home/home.dart';
import 'utils/app_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final AuthServices authServices = AuthServices();
  final PostServices postServices = PostServices();
  runApp(MyApp(
    authServices: authServices,
    prefs: prefs,
    postServices: postServices,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final AuthServices authServices;
  final PostServices postServices;

  const MyApp(
      {super.key,
      required this.prefs,
      required this.authServices,
      required this.postServices});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authServices, prefs),
        ),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider(postServices))
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0XFF007AFF))),
        home: AuthWrapper(
          authServices: authServices,
          prefs: prefs,
        ),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  final SharedPreferences prefs;
  final AuthServices authServices;
  const AuthWrapper(
      {super.key, required this.prefs, required this.authServices});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  void start() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (authProvider.isCheckingAuth) {
      return const Splashscreen(); // Tampilkan SplashScreen saat startup
    }

    // Menampilkan layar yang berbeda berdasarkan status login
    if (authProvider.isLoggedIn) {
      // Jika sudah login, arahkan ke HomePage
      return const Home();
    } else {
      // Jika belum login, arahkan ke LoginPage
      return const Login();
    }
  }
}
