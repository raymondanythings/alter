import 'package:alter/constants/gaps.dart';
import 'package:alter/constants/sizes.dart';
import 'package:alter/features/diary/view_models/diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Diary extends ConsumerStatefulWidget {
  static const String routeName = "diary";
  static const String routeUrl = "diary";

  final int index;

  const Diary({
    super.key,
    required this.index,
  });

  @override
  ConsumerState<Diary> createState() => _DiaryState();
}

class _DiaryState extends ConsumerState<Diary> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(diaryProvider).when(
          data: (diaries) {
            final diary = diaries[widget.index];
            return Scaffold(
              body: Stack(
                children: [
                  Hero(
                    tag: '${diary.createdAt}',
                    child: Image.network(
                      diary.picture,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                  SlidingUpPanel(
                    maxHeight: MediaQuery.of(context).size.height - 100,
                    minHeight: 120,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(
                        Sizes.size14,
                      ),
                    ),
                    panel: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size14,
                        horizontal: Sizes.size10,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    diary.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      foregroundImage: NetworkImage(
                                        "https://avatars.githubusercontent.com/u/73725736",
                                      ),
                                    ),
                                    Gaps.h10,
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "@Raymond",
                                          style: TextStyle(
                                            fontSize: Sizes.size10,
                                          ),
                                        ),
                                        Gaps.v2,
                                        Text(
                                          "Do your best, if u want it.",
                                          style: TextStyle(
                                            fontSize: Sizes.size8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Gaps.v10,
                            Text(
                              diary.diary,
                              style: const TextStyle(
                                fontSize: Sizes.size12,
                              ),
                            ),
                            Text(
                              diary.diary,
                            ),
                          ],
                        ),
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
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => const Center(
            child: Text("Could not find diaries."),
          ),
        );
  }
}
