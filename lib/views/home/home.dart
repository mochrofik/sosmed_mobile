import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yure_connect_apps/provider/home_provider.dart';
import 'package:yure_connect_apps/provider/post_provider.dart';
import 'package:yure_connect_apps/utils/AppColors.dart';
import 'package:yure_connect_apps/views/home/posts.dart';
import 'package:yure_connect_apps/views/home/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      const Posts(),
      const Center(
        child: Text("Kamera"),
      ),
      const Profile(),
    ];

    final postProvider = context.watch<PostProvider>();

    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Appcolors.primaryColor,
              onTap: (value) {
                print(value);
                homeProvider.currentNavigate(value);

                if (value == 1) {
                  postProvider.pickImage(ImageSource.gallery);
                }
              },
              currentIndex: homeProvider.currentBottomNavigate,
              items: const [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(
                    Icons.home_rounded,
                    size: 35,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Posting",
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 40,
                  ),
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.solidCircleUser,
                      size: 30,
                    ),
                    label: "Profile"),
              ]),
          body: pages[homeProvider.currentBottomNavigate]);
    });
  }
}
