
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ThemeModeType { light, dark }

class ThemeNotifier extends StateNotifier<ThemeModeType> {
  ThemeNotifier() : super(ThemeModeType.light);

  void toggleTheme() {
    state =
        state == ThemeModeType.light ? ThemeModeType.dark : ThemeModeType.light;
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeModeType>((ref) {
  return ThemeNotifier();
});
