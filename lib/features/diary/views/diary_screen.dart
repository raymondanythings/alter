import 'package:alter/common/views/widgets/sliver_persistent_search_bar.dart';
import 'package:alter/constants/breakpoints.dart';
import 'package:alter/constants/sizes.dart';
import 'package:alter/features/diary/models/diary_model.dart';
import 'package:alter/features/diary/view_models/diary_view_model.dart';
import 'package:alter/features/diary/views/widgets/diary.dart';
import 'package:alter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DiaryScreen extends ConsumerStatefulWidget {
  const DiaryScreen({super.key});

  @override
  ConsumerState<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends ConsumerState<DiaryScreen> {
  late TextEditingController _controller;

  void _onDiaryTap(int index) {
    context.pushNamed(Diary.routeName, pathParameters: {
      'index': index.toString(),
    });
  }

  Future<void> _onRemoveDiary(String? docId) async {
    if (docId != null) {
      await ref.read(diaryProvider.notifier).removeDiary(docId);
    }
    context.pop();
  }

  void _onDeleteTap(DiaryModel diary) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
            title: const Text("Delete Diary"),
            message: const Text(
              "Are you sure you want to do this?",
            ),
            actions: [
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () => _onRemoveDiary(diary.id),
                child: const Text(
                  "Delete",
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                context.pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(diaryProvider).when(
          data: (diaries) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    // pinned: true,
                    floating: true,
                    delegate: SliverPersistentSearchBar(
                      controller: _controller,
                      onSubmitted: (value) {},
                      onSuffixTap: () {},
                    ),
                  ),
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      await ref.read(diaryProvider.notifier).refetch();
                    },
                  ),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () => _onDiaryTap(index),
                          onLongPress: () => _onDeleteTap(diaries[index]),
                          child: Container(
                            padding: const EdgeInsets.all(
                              Sizes.size10,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Sizes.size14,
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Hero(
                                  tag: '${diaries[index].createdAt}',
                                  child: Image.network(
                                    diaries[index].picture,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: diaries.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
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

class SearchBar extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onSuffixTap;
  final TextEditingController? controller;

  const SearchBar({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.onSuffixTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: Breakpoints.sm,
      ),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size10,
          vertical: Sizes.size10,
        ),
        child: CupertinoSearchTextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onSuffixTap: onSuffixTap,
          suffixIcon: const Icon(FontAwesomeIcons.paperPlane),
          suffixMode: OverlayVisibilityMode.always,
          style: TextStyle(
            color: isDarkMode(context) ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
