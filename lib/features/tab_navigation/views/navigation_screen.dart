import 'package:alter/constants/sizes.dart';
import 'package:alter/features/diary/views/diary_screen.dart';
import 'package:alter/features/diary/views/write_diary_screen.dart';
import 'package:alter/features/tab_navigation/views/widgets/nav_tab.dart';
import 'package:alter/features/users/views/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigation extends ConsumerStatefulWidget {
  static const String routeName = "main_navigaiton";
  static const String routeUrl = "/";
  const MainNavigation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late AnimationController _modalAnimateController;
  int _currentIndex = 0;

  void _onCheckKeyboardOpen() {
    final bool isVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    if (isVisible) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void _onNavTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeInOut,
    );
  }

  void _onWriteButtonTap() async {
    _modalAnimateController.reverse();
    await showModalBottomSheet(
      useSafeArea: false,
      context: context,
      isScrollControlled: true,
      builder: (context) => const FractionallySizedBox(
        heightFactor: 0.93,
        widthFactor: 1,
        child: WriteDiaryScreen(),
      ),
    );
    _modalAnimateController.forward();
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _modalAnimateController = AnimationController(
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1,
      value: 1,
      duration: const Duration(
        milliseconds: 150,
      ),
    );
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    _modalAnimateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onCheckKeyboardOpen,
      child: AnimatedBuilder(
        animation: _modalAnimateController,
        builder: (context, child) => Transform.scale(
          scale: _modalAnimateController.value,
          child: child,
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                Sizes.size24,
              ),
            ),
          ),
          child: Scaffold(
            body: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              children: const [
                DiaryScreen(),
                UserProfileSCreen(),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              padding: const EdgeInsets.all(
                Sizes.size4,
              ),
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavTab(
                    isSelected: _currentIndex == 0,
                    icon: FontAwesomeIcons.house,
                    selectedIcon: FontAwesomeIcons.house,
                    onTap: () => _onNavTap(0),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  NavTab(
                    isSelected: _currentIndex == 1,
                    icon: FontAwesomeIcons.person,
                    selectedIcon: FontAwesomeIcons.person,
                    onTap: () => _onNavTap(1),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              onPressed: _onWriteButtonTap,
              shape: const CircleBorder(),
              child: FaIcon(
                FontAwesomeIcons.pencil,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
