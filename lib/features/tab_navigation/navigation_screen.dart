import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavigation extends ConsumerStatefulWidget {
  static const String routeName = "main_navigaiton";
  const MainNavigation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
