import 'package:flutter/material.dart';
import 'package:yure_connect_apps/utils/GlobalFunctions.dart';

class PasswordCard extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  final Function()? onTapIcon;
  final String? Function(String?)? validator;
  const PasswordCard(
      {super.key,
      this.obscureText = false,
      this.hintText = "",
      required this.onTapIcon,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      validator: validator,
      obscureText: obscureText,
      decoration:
          GlobalFunctions.decorationPassword(hintText, obscureText, onTapIcon),
      controller: controller,
    );
  }
}
