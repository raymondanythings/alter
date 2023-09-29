import 'package:alter/common/repository/platform_theme_repository.dart';
import 'package:alter/common/view_model/platform_theme_view_model.dart';
import 'package:alter/firebase_options.dart';
import 'package:alter/router_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final preferences = await SharedPreferences.getInstance();
  final repository = PlatformThemeRepository(preferences);

  final isDarkMode =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
  repository.setTheme(isDarkMode);

  runApp(
    ProviderScope(
      overrides: [
        platformThemeProvider.overrideWith(
          () => PlatformThemeViewModel(
            repository,
            isDarkMode,
          ),
        ),
      ],
      child: const Alter(),
    ),
  );
}

class Alter extends ConsumerWidget {
  const Alter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      SchedulerBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
          () {
        final isDarkMode =
            SchedulerBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark;
        ref.read(platformThemeProvider.notifier).setTheme(isDarkMode);
      };
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Alter',
      theme: ref.watch(platformThemeProvider).isDarkMode
          ? Theme.dark
          : Theme.light,
      routerConfig: ref.watch(routerProvider),
    );
  }
}

class Theme {
  static final ThemeData light = ThemeData(
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: const Color(
      0xFFFEF8E5,
    ),
    textTheme: Typography.blackCupertino,
    scaffoldBackgroundColor: const Color(
      0xFFFEF7E3,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      surfaceTintColor: Colors.white,
      color: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white,
    ),
  );

  static final ThemeData dark = ThemeData(
    // Ripple 효과 지우기
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: const Color(
      0xff0B63E0,
    ),
    textTheme: Typography.whiteCupertino,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(
      0xFF111111,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(
        0xFF111111,
      ),
      surfaceTintColor: Color(
        0xFF111111,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(
          Colors.white,
        ),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(
        0xFF111111,
      ),
    ),
  );
}
