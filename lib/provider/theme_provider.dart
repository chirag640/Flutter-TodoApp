import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
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