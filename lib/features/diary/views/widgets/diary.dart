import 'package:alter/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class Diary extends StatefulWidget {
  static const String routeName = "diary";
  static const String routeUrl = "diary";
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 9 / 16,
                child: Hero(
                  tag: "image0",
                  child: Image.asset(
                    "assets/images/bg_1.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: Sizes.size40,
                left: Sizes.size10,
                child: IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ],
          ),
          // const ListTile(
          //   contentPadding: EdgeInsets.zero,
          //   visualDensity: VisualDensity.compact,
          //   dense: true,
          //   leading: CircleAvatar(
          //     radius: Sizes.size16,
          //   ),
          //   title: Text(
          //     "@Raymond",
          //     style: TextStyle(
          //       fontSize: Sizes.size12,
          //     ),
          //   ),
          //   subtitle: Text(
          //     "what is summary here?",
          //     style: TextStyle(
          //       fontSize: Sizes.size10,
          //     ),
          //   ),
          // ),
          // const Row(
          //   children: [
          //     Text(
          //       "Why do we use it?",
          //       style: TextStyle(
          //           fontSize: Sizes.size16, fontWeight: FontWeight.w500),
          //     ),
          //   ],
          // ),
          // const Text(
          //   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   style: TextStyle(
          //     fontSize: Sizes.size12,
          //   ),
          // ),
        ],
      ),
    );
  }
}
