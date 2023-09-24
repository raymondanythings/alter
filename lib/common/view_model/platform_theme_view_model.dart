import 'package:alter/common/models/platform_theme_model.dart';
import 'package:alter/common/repository/platform_theme_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlatformThemeViewModel extends Notifier<PlatformThemeModel> {
  final PlatformThemeRepository _repository;
  final bool isSystemDark;

  void setTheme(bool value) {
    _repository.setTheme(value);
    state = PlatformThemeModel(
      isDarkMode: value,
    );
  }

  PlatformThemeViewModel(
    this._repository,
    this.isSystemDark,
  );

  @override
  PlatformThemeModel build() {
    return PlatformThemeModel(
      isDarkMode: _repository.getTheme() ?? isSystemDark,
    );
  }
}

final platformThemeProvider =
    NotifierProvider<PlatformThemeViewModel, PlatformThemeModel>(
  () => throw UnimplementedError(),
);
