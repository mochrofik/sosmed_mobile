import 'package:flutter/material.dart';
import 'package:yure_connect_apps/components/buttons/buttoncustom.dart';
import 'package:yure_connect_apps/utils/AppColors.dart';
import 'app_margin.dart';

class CustomDialog {
  static confirmDeleteDialog({
    required BuildContext context,
    required dynamic Function()? onPressed,
  }) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (contextDialog) {
          return Dialog(
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  height15,
                  const Text(
                    "Yakin ingin menghapus postingan ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonCustom(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        backgroundColor: Colors.grey.shade200,
                        child: const Text(
                          "Batal",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      width15,
                      ButtonCustom(
                        onPressed: () async {
                          if (onPressed != null) {
                            await onPressed();
                          }
                          Navigator.of(contextDialog).pop();
                        },
                        backgroundColor: Colors.red.shade700,
                        child: const Text(
                          "Hapus",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  static logoutDialog({
    required BuildContext context,
    required dynamic Function()? onPressed,
  }) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (contextDialog) {
          return Dialog(
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  height15,
                  const Text(
                    "Yakin ingin logout dari aplikasi ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonCustom(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        backgroundColor: Colors.grey.shade200,
                        child: const Text(
                          "Batal",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      width15,
                      ButtonCustom(
                        onPressed: () async {
                          if (onPressed != null) {
                            await onPressed();
                          }
                          Navigator.of(contextDialog).pop();
                        },
                        backgroundColor: Appcolors.primaryColor,
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
