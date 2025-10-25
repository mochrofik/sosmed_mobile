import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yure_connect_apps/components/buttons/buttoncustom.dart';
import 'package:yure_connect_apps/provider/auth_provider.dart';
import 'package:yure_connect_apps/utils/AppColors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text("Profile"),
                ),
                Consumer<AuthProvider>(
                    builder: (context, authProvider, snapshot) {
                  return ButtonCustom(
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                      },
                      backgroundColor: Appcolors.primaryColor,
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ));
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
