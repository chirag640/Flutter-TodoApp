import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/constants/colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

 ThemeProvider() {
    _loadTheme();
  }
  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }
  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get lightTheme {
    return ThemeData(
      primaryColor: tdBlue,
      colorScheme: ColorScheme.light(
        primary: tdBlue,
        surface: tdBgColor,
      ),
      scaffoldBackgroundColor: tdBgColor,
      appBarTheme: AppBarTheme(
        backgroundColor: tdBgColor,
        iconTheme: IconThemeData(color: tdBlack),
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(color: tdBlack),
        bodyLarge: TextStyle(color: tdBlack),
        bodyMedium: TextStyle(color: tdBlack),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      primaryColor: tdDarkBlue,
      colorScheme: ColorScheme.dark(
        primary: tdDarkBlue,
        surface: tdDarkBgColor,
      ),
      scaffoldBackgroundColor: tdDarkBgColor,
      appBarTheme: AppBarTheme(
        backgroundColor: tdDarkGrey,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
      ),
    );
  }
}