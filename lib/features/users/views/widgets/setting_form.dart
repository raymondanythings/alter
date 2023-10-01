import 'dart:async';

import 'package:alter/common/view_model/platform_theme_view_model.dart';
import 'package:alter/constants/sizes.dart';
import 'package:alter/features/authenticate/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingForm extends ConsumerStatefulWidget {
  const SettingForm({super.key});

  @override
  SettingFormState createState() => SettingFormState();
}

class SettingFormState extends ConsumerState<SettingForm> {
  bool _isLoading = false;

  void _popNavigation() {
    context.pop();
  }

  Future<void> _onLogout() async {
    _popNavigation();
    setState(() {
      _isLoading = true;
    });
    await ref.read(authRepository).signOut();
    setState(() {
      _isLoading = false;
    });
  }

  void _onLogoutTap() async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Are you sure?"),
        actions: [
          CupertinoDialogAction(
            onPressed: _popNavigation,
            child: const Text("No"),
          ),
          CupertinoDialogAction(
            onPressed: _onLogout,
            isDestructiveAction: true,
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(platformThemeProvider).isDarkMode;
    return Column(
      children: [
        SwitchListTile.adaptive(
          value: isDark,
          onChanged: (value) {
            ref.read(platformThemeProvider.notifier).setTheme(value);
          },
          title: const Text(
            "Enable Dark Mode",
          ),
        ),
        GestureDetector(
          onTap: _onLogoutTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                Sizes.size14,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sign out",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    child: _isLoading
                        ? const CircularProgressIndicator.adaptive()
                        : Container(),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
