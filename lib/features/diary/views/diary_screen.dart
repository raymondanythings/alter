import 'package:alter/common/views/widgets/sliver_persistent_search_bar.dart';
import 'package:alter/constants/breakpoints.dart';
import 'package:alter/constants/sizes.dart';
import 'package:alter/features/diary/views/widgets/diary.dart';
import 'package:alter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late TextEditingController _controller;

  void _onDiaryTap() {
    context.pushNamed(Diary.routeName);
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
              await Future<void>.delayed(
                const Duration(milliseconds: 1000),
              );
            },
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: _onDiaryTap,
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
                          tag: 'image$index',
                          child: Image.asset(
                            "assets/images/bg_1.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: 20,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
          ),
        ],
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
