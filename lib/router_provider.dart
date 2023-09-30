import 'package:alter/features/authenticate/repository/auth_repository.dart';
import 'package:alter/features/authenticate/views/auth_screen.dart';
import 'package:alter/features/diary/views/widgets/diary.dart';
import 'package:alter/features/tab_navigation/navigation_screen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepository).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != AuthScreen.routeUrl) {
          return AuthScreen.routeUrl;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AuthScreen.routeUrl,
        name: AuthScreen.routeName,
        builder: (context, state) {
          return const AuthScreen();
        },
      ),
      GoRoute(
        path: MainNavigation.routeUrl,
        name: MainNavigation.routeName,
        builder: (context, state) => const KeyboardVisibilityProvider(
          child: MainNavigation(),
        ),
        routes: [
          GoRoute(
            path: Diary.routeUrl,
            name: Diary.routeName,
            builder: (context, state) {
              return const Diary();
            },
          )
        ],
      ),
    ],
  ),
);
