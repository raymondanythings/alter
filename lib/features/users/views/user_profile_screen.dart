import 'package:alter/constants/gaps.dart';
import 'package:alter/constants/sizes.dart';
import 'package:alter/features/users/views/widgets/setting_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

class UserProfileSCreen extends ConsumerStatefulWidget {
  const UserProfileSCreen({super.key});

  @override
  UserProfileSCreenState createState() => UserProfileSCreenState();
}

class UserProfileSCreenState extends ConsumerState<UserProfileSCreen> {
  void _onGearPressed() {
    context.push("/settings");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "@Raymond",
            style: TextStyle(
              fontSize: Sizes.size24,
              fontWeight: FontWeight.w600,
            ),
          ),
          // actions: const [
          //   Gaps.h10,
          //   IconButton(
          //     onPressed: _onGearPressed,
          //     icon: FaIcon(
          //       FontAwesomeIcons.barsStaggered,
          //       size: Sizes.size28,
          //     ),
          //   ),
          // ],
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.size20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 35,
                    foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/73725736",
                    ),
                  ),
                ),
                Gaps.v14,
                Text(
                  "Do your best, if u want it.",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
                Gaps.v14,
                SettingForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
