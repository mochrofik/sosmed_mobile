import 'package:flutter/material.dart';
import 'package:yure_connect_apps/utils/GlobalFunctions.dart';

class TextFormCard extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  const TextFormCard(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      validator: validator,
      decoration: GlobalFunctions.inputBorderForm(hintText),
      controller: controller,
    );
  }
}
