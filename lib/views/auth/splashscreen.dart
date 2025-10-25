import 'package:flutter/material.dart';
import 'package:yure_connect_apps/components/yuretext.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: YureText(),
          ))
        ],
      ),
    );
  }
}
