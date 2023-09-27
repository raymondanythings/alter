import 'dart:async';
import 'package:alter/features/authenticate/repository/auth_repository.dart';
import 'package:alter/features/tab_navigation/navigation_screen.dart';
import 'package:alter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepository);
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.signIn(email, password),
    );

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go(
        MainNavigation.routeUrl,
      );
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
