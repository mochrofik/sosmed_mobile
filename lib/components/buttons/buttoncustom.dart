import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final Color backgroundColor;

  const ButtonCustom(
      {super.key,
      required this.child,
      required this.onPressed,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            backgroundColor: backgroundColor),
        onPressed: onPressed,
        child: child);
  }
}
