import 'package:flutter/material.dart';
import 'package:yure_connect_apps/utils/AppColors.dart';

class GlobalFunctions {
  static InputDecoration inputBorderForm(hintText) {
    final radius10 = BorderRadius.circular(10);
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: radius10,
            borderSide: const BorderSide(
              color: Colors.black45,
            )),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: radius10,
            borderSide: BorderSide(
              color: Appcolors.primaryColor,
            )),
        disabledBorder: OutlineInputBorder(
            borderRadius: radius10,
            borderSide: BorderSide(
              color: Appcolors.primaryColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: radius10,
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(10),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black45,
        ));
  }

  static InputDecoration decorationPassword(
      hintText, bool isObscure, Function()? onTapSuffix) {
    final radius10 = BorderRadius.circular(10);
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: radius10,
            borderSide: const BorderSide(
              color: Colors.black45,
            )),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: radius10,
            borderSide: BorderSide(
              color: Appcolors.primaryColor,
            )),
        disabledBorder: OutlineInputBorder(
            borderRadius: radius10,
            borderSide: BorderSide(
              color: Appcolors.primaryColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: radius10,
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(10),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black45,
        ),
        suffixIcon: InkWell(
          onTap: onTapSuffix,
          child: isObscure
              ? const Icon(
                  Icons.lock_outline_rounded,
                  size: 20,
                )
              : const Icon(
                  Icons.lock_open_outlined,
                  size: 20,
                ),
        ));
  }
}
