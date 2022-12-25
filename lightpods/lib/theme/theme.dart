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
  toggleButtonsTheme: toggleButtonsThemeData,
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

ToggleButtonsThemeData toggleButtonsThemeData = ToggleButtonsThemeData(
  borderRadius: const BorderRadius.all(Radius.circular(8)),
  selectedBorderColor: ThemeColors.selectedItemColor,
  selectedColor: ThemeColors.backgroundColor,
  fillColor: ThemeColors.selectedItemColor,
  color: Colors.white,
  constraints: const BoxConstraints(
    minHeight: 40.0,
    minWidth: 80.0,
  ),
);
