import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yure_connect_apps/components/yuretext.dart';
import 'package:yure_connect_apps/constants/Globals.dart';
import 'package:yure_connect_apps/models/post_model.dart';
import 'package:yure_connect_apps/provider/post_provider.dart';
import 'package:yure_connect_apps/utils/AppColors.dart';
import 'package:yure_connect_apps/utils/app_margin.dart';

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    final postsProv = Provider.of<PostProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            title: const YureText(
              fontColor: Colors.white,
            ),
            backgroundColor: Appcolors.primaryColor,
            floating: true,
            pinned: false,
            actions: [
              Icon(
                Icons.search,
                color: Colors.white,
              )
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
              postsProv.mypost();
            },
          ),
          Consumer<PostProvider>(builder: (context, post, child) {
            return SliverList.builder(
                itemCount: post.list.length,
                itemBuilder: (context, i) {
                  return konten(i, post.list[i], post);
                });
          })
        ],
      ),
    );
  }

  konten(indexPos, PostModel data, PostProvider post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              width10,
              CircleAvatar(
                maxRadius: 20,
                backgroundImage: NetworkImage(
                  "${Globals.urlPostImage}/${data.profile.split("\\").last}",
                ),
              ),
              width10,
              Text(data.user.name),
            ],
          ),
          height10,
          Container(
            color: Colors.white,
            child: CarouselSlider(
              carouselController: CarouselSliderController(),
              options: CarouselOptions(
                height: 300.0,
                aspectRatio: 1,
                viewportFraction: 1,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  post.changeIndexImg(indexPos, index);

                  print(index);
                  print(reason);
                  print(data.indexImg);
                },
              ),
              items: data.uploadPostings.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Image.network(
                        "${Globals.urlPostImage}/${i.fileUrl.split("\\").last}",
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${Globals.urlPostImage}/${i.fileUrl.split("\\").last}",
                                ),
                                const Icon(
                                  FontAwesomeIcons.image,
                                  size: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          // Tampilkan progress bar saat loading
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ));
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          height15,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                data.uploadPostings.length,
                (int index) => Icon(
                      Icons.circle,
                      size: 10,
                      color: index == data.indexImg
                          ? Appcolors.primaryColor
                          : Colors.grey,
                    )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Row(
              children: [
                likeBtn(data.likes),
                width15,
                btnComment(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    data.posting,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row btnComment() {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: const Icon(
            FontAwesomeIcons.comment,
            size: 24,
          ),
        ),
        width10,
        const Text(
          "0",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  likeBtn(int like) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: const Icon(
            Icons.thumb_up_alt_outlined,
            // Icons.thumb_up_alt,
            // color: Appcolors.primaryColor,
            color: Colors.black87,
            size: 25,
          ),
        ),
        width10,
        Text(
          like.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
