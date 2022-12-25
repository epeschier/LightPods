import 'package:flutter/material.dart';

class ThemeColors {
  static Color backgroundColor = const Color.fromARGB(255, 34, 44, 49);
  static Color selectedItemColor = const Color.fromARGB(255, 251, 215, 52);
  static Color unselectedItemColor = const Color.fromARGB(255, 96, 125, 139);

  static Color buttonColor = selectedItemColor;
  static Color buttonIconColor = backgroundColor;
  static Color buttonDisabledIconColor = unselectedItemColor;
}

ThemeData appTheme = ThemeData(
  //primarySwatch: MaterialColor. Color(0xff607D8B);
  brightness: Brightness.dark,
  useMaterial3: false,
  bottomNavigationBarTheme: bottomNavigationBarTheme,
);

BottomNavigationBarThemeData bottomNavigationBarTheme =
    BottomNavigationBarThemeData(
  backgroundColor: ThemeColors.backgroundColor,
  selectedItemColor: ThemeColors.selectedItemColor,
  unselectedItemColor: ThemeColors.unselectedItemColor,
  showSelectedLabels: false,
  showUnselectedLabels: false,
);

ButtonStyle toggleButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.lightBlue[800],
    shape: const CircleBorder(),
    padding: const EdgeInsets.all(20),
    textStyle: TextStyle(
        color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 40));
