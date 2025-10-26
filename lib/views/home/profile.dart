import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yure_connect_apps/components/buttons/buttoncustom.dart';
import 'package:yure_connect_apps/constants/Globals.dart';
import 'package:yure_connect_apps/provider/auth_provider.dart';
import 'package:yure_connect_apps/provider/profile_provider.dart';
import 'package:yure_connect_apps/utils/AppColors.dart';
import 'package:yure_connect_apps/utils/app_margin.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      body:
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 2));
                profileProvider.myProfile();
              },
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Appcolors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      height10,
                      ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(80), // Radius lingkaran
                          child: Image.network(
                            "${Globals.urlPostImage}/${profileProvider.userModel?.profile.split("\\ada").last}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  child: const Icon(
                                    Icons.person,
                                    size: 80 * 1.2, // Sesuaikan ukuran ikon
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const CircularProgressIndicator(); // Placeholder saat loading
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: height15,
            ),
            SliverToBoxAdapter(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      profileProvider.userModel?.name ?? "",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: height15,
            ),
            SliverToBoxAdapter(
              child: Consumer<AuthProvider>(
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
              }),
            )
          ],
        );
      }),
    );
  }
}
