import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/config/themes/dark_theme_constants.dart';
import 'package:whatsappclone/config/themes/light_theme_constants.dart';

class CustomTheme extends ChangeNotifier {
  static bool _isDark = false;
  static final _lightThemeConstants = LightThemeConstants();
  static final _darkThemeConstants = DarkThemeConstants();
  static ThemeData _lightTheme = ThemeData(
    primaryColor: _lightThemeConstants.primaryColor,
    accentColor: _lightThemeConstants.accentColor,
  );
  static ThemeData _darkTheme = ThemeData(
    primaryColor: _darkThemeConstants.primaryColor,
    accentColor: _darkThemeConstants.accentColor,
  );

  static ThemeData get getTheme {
    if (!_isDark) return _darkTheme;
    return _lightTheme;
  }
}
