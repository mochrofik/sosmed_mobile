import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yure_connect_apps/constants/Globals.dart';
import 'package:yure_connect_apps/provider/auth_provider.dart';
import 'package:yure_connect_apps/provider/profile_provider.dart';
import 'package:yure_connect_apps/utils/AppColors.dart';
import 'package:yure_connect_apps/utils/app_margin.dart';
import 'package:yure_connect_apps/utils/custom_dialog.dart';
import 'package:yure_connect_apps/views/widget/card_mypost.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context);
    return Scaffold(
      body:
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 2));
                      profileProvider.myProfile();
                      profileProvider.myPost();
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: Appcolors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                const Text(
                                  "Profile",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        CustomDialog.logoutDialog(
                                            context: context,
                                            onPressed: () {
                                              Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .logout();
                                            });
                                      },
                                      child: const Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            height10,
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(85)),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(50),
                                      child: Image.network(
                                        "${Globals.urlPostImage}/${profileProvider.userModel?.profile.split("\\").last}",
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return ClipOval(
                                            child: Container(
                                              color: Colors.white,
                                              child: const Icon(
                                                Icons.person,
                                                size: 50 *
                                                    1.2, // Sesuaikan ukuran ikon
                                                color: Colors.grey,
                                              ),
                                            ),
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const CircularProgressIndicator(); // Placeholder saat loading
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        )),
                                    padding: const EdgeInsets.all(3),
                                    child: InkWell(
                                      child: Icon(
                                        Icons.edit_square,
                                        size: 15,
                                        color: Appcolors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            height10,
                            Text(
                              profileProvider.userModel?.name ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              profileProvider.userModel?.email ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            height15,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "1K",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                width10,
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "2K",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                width10,
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Posts",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "20",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: height10,
                  ),
                  SliverToBoxAdapter(
                    child: Consumer<ProfileProvider>(
                        builder: (context, post, child) {
                      return GridView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: post.list.length,
                          itemBuilder: (context, i) {
                            var item = post.list[i];
                            return CardMypost(
                              urlImage:
                                  "${Globals.urlPostImage}/${item.uploadPostings[0].fileUrl.split("\\").last}",
                            );
                          });
                    }),
                  )
                ],
              ),
            ),
            height15
          ],
        );
      }),
    );
  }
}
