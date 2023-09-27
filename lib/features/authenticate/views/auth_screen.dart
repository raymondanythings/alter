import 'dart:math';
import 'package:alter/features/authenticate/views/widgets/grid_background.dart';
import 'package:alter/features/authenticate/views/widgets/login_form.dart';
import 'package:alter/features/authenticate/views/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  static const String routeUrl = "/auth";
  static const String routeName = "auth";

  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  void _onNavigationTap(String type) {
    _selectedAuthType = type;
    setState(() {});
  }

  String _selectedAuthType = "login";
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
          Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    const Color(0xFF000000).withOpacity(0.8),
                    const Color(0xFF000000).withOpacity(
                      0.5,
                    ),
                    const Color(0xFF000000).withOpacity(
                      0.3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Stack(
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
    );
  }
}
