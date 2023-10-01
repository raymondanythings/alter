import 'dart:math';
import 'package:alter/constants/gaps.dart';
import 'package:alter/constants/sizes.dart';
import 'package:alter/features/authenticate/views/widgets/grid_background.dart';
import 'package:alter/features/authenticate/views/widgets/login_form.dart';
import 'package:alter/features/authenticate/views/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeUrl = "/auth";
  static const String routeName = "auth";

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _selectedAuthType = "login";

  final GlobalKey _stackKey = GlobalKey();

  void _onNavigationTap(String type) {
    setState(() {
      _selectedAuthType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: -MediaQuery.of(context).size.width * 0.3,
            top: -MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 5,
            child: Transform.rotate(
              alignment: Alignment.center,
              angle: pi * 8 / 180,
              child: const GridBackground(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(
                  0,
                  0.3,
                ),
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                ],
              ),
            ),
            alignment: Alignment.bottomCenter,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Alter',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Sizes.size20,
                  ),
                ),
                Gaps.v14,
                Stack(
                  key: _stackKey,
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.loose,
                  children: [
                    Offstage(
                      offstage: _selectedAuthType != 'login',
                      child: LoginForm(
                        onNavigationtap: () => _onNavigationTap("signup"),
                      ),
                    ),
                    Offstage(
                      offstage: _selectedAuthType != 'signup',
                      child: SignUpForm(
                        onNavigationtap: () => _onNavigationTap("login"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
