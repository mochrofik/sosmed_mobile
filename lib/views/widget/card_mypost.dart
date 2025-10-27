import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yure_connect_apps/utils/AppColors.dart';

class CardMypost extends StatelessWidget {
  final String urlImage;
  const CardMypost({super.key, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.image,
                  size: 50,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        loadingBuilder: (context, child, loadingProgress) {
          // Tampilkan progress bar saat loading
          if (loadingProgress == null) return child;
          return Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Appcolors.primaryColor,
              ),
            ],
          ));
        },
      ),
    );
  }
}
