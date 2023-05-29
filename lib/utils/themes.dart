import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color bluishClr = Color(0xff4e5ae8);
const Color yellorClr = Color(0xffffb746);
const Color pinkClr = Color(0xffff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGryClr = Color(0xff121212);
const Color darkHeaderClr = Color(0xff424242);

class ThemeProvider with ChangeNotifier {
  final String _key = 'isDarkMode';
  late SharedPreferences _prefs;

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _initPreferences();
    _loadThemeMode();
  }

  void _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadThemeMode() async {
    final isDarkMode = _prefs.getBool(_key) ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void _saveThemeMode() async {
    await _prefs.setBool(_key, _themeMode == ThemeMode.dark);
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode();
    notifyListeners();
  }
}

class Themes {
  static final light = ThemeData(
    primaryColor: bluishClr,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: darkGryClr,
    brightness: Brightness.dark,
  );
}
