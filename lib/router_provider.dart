import 'package:alter/features/authenticate/repository/auth_repository.dart';
import 'package:alter/features/authenticate/views/login_screen.dart';
import 'package:alter/features/authenticate/views/sign_up_screen.dart';
import 'package:alter/features/tab_navigation/navigation_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepository).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != LoginScreen.routeUrl &&
            state.matchedLocation != SignUpScreen.routeUrl) {
          return LoginScreen.routeUrl;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: LoginScreen.routeUrl,
        name: LoginScreen.routeName,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: SignUpScreen.routeUrl,
        name: SignUpScreen.routeName,
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: "/",
        builder: (context, state) => const MainNavigation(),
      ),
    ],
  ),
);
