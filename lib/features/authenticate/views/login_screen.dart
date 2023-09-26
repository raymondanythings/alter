import 'dart:async';

import 'package:alter/constants/sizes.dart';
import 'package:alter/features/authenticate/view_models/login_view_model.dart';
import 'package:alter/features/authenticate/views/sign_up_screen.dart';
import 'package:alter/features/authenticate/views/widgets/form_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeUrl = "/login";
  static const String routeName = "login";

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> imageList = [1, 2, 3, 4, 5, 6, 7, 8]
      .map(
        (e) => 'assets/images/bg_$e.png',
      )
      .toList();
  Map<String, String> formData = {};

  int _seconds = 0;
  int _backgroundIndex = 0;
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      if (_seconds % 10 == 0) {
        _backgroundIndex = ++_backgroundIndex % 8;
        setState(() {});
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _onSaveFormData(String key, String? value) {
    if (value != null) {
      formData[key] = value;
    }
  }

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        ref
            .read(loginProvider.notifier)
            .login(formData["email"]!, formData["password"]!, context);

        // // context.goNamed(
        // //   InterestsScreen.routeName,
        // // );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      child: Container(
                        key: ValueKey(
                          imageList[_backgroundIndex],
                        ),
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              Sizes.size12,
                            ),
                          ),
                        ),
                        child: Image.asset(
                          imageList[_backgroundIndex],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    TextFormField(
                      onSaved: (newValue) => _onSaveFormData("email", newValue),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Plase write your email";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      onSaved: (newValue) =>
                          _onSaveFormData("password", newValue),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Plase write your password";
                        }
                        return null;
                      },
                    ),
                    FormButton(
                      onTap: _onSubmitTap,
                      disabled: false,
                      text: "Login",
                    ),
                    CupertinoButton(
                      child: const Text("Create Account"),
                      onPressed: () {
                        context.pushNamed(SignUpScreen.routeName);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
