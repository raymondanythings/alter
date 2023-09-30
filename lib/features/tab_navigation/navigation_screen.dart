import 'package:alter/features/diary/views/diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavigation extends ConsumerStatefulWidget {
  static const String routeName = "main_navigaiton";
  static const String routeUrl = "/";
  const MainNavigation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation> {
  late final PageController _pageController;
  int _currentIndex = 0;

  void _onCheckKeyboardOpen() {
    final bool isVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    if (isVisible) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onCheckKeyboardOpen,
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
            Center(
              child: Text("2"),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.easeInOut,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Start",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_enhance),
              label: "Second",
            ),
          ],
        ),
      ),
    );
  }
}
