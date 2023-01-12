import 'package:flutter/material.dart';

class ThemeColors {
  static Color darkPrimaryColor = const Color(0xff455A64);
  static Color lightPrimaryColor = const Color(0xffCFD8DC);
  static Color primaryColor = const Color(0xff607D8B);
  static Color textIconColor = const Color(0xffFFFFFF);
  static Color accentColor = const Color(0xffFFC107);
  static Color primaryTextColor = const Color(0xff212121);
  static Color secondaryTextColor = const Color(0xff757575);
  static Color dividerColor = const Color(0xffDBDBDB);

  static Color backgroundColor = const Color.fromARGB(255, 34, 44, 49);
  static Color selectedItemColor = accentColor;
  static Color unselectedItemColor = const Color.fromARGB(255, 96, 125, 139);

  static Color buttonColor = accentColor;
  static Color buttonIconColor = primaryTextColor;
  static Color buttonDisabledIconColor = unselectedItemColor;

  static TextStyle headerText = const TextStyle(
    letterSpacing: 0.5,
    fontSize: 18,
  );

  static TextStyle headerValueText = TextStyle(
    color: ThemeColors.lightPrimaryColor,
    letterSpacing: 0.5,
    fontSize: 14,
  );

  static TextStyle valueText = const TextStyle(
    letterSpacing: 0.5,
    fontSize: 24,
  );

  static TextStyle sliderHeaderText = const TextStyle(
    letterSpacing: 0.5,
    fontSize: 16,
  );

  static TextStyle subText = const TextStyle(
    color: Color.fromARGB(255, 128, 128, 128),
    letterSpacing: 0.5,
    fontSize: 12,
  );
}

ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: ThemeColors.darkPrimaryColor,
    brightness: Brightness.dark,
    useMaterial3: false,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    toggleButtonsTheme: toggleButtonsThemeData,
    floatingActionButtonTheme: floatingActionButtonThemeData,
    sliderTheme: sliderTheme,
    appBarTheme: appbarTheme);

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
    padding: const EdgeInsets.all(16),
    textStyle: TextStyle(
        color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 40));

ToggleButtonsThemeData toggleButtonsThemeData = ToggleButtonsThemeData(
  borderRadius: const BorderRadius.all(Radius.circular(4)),
  selectedBorderColor: ThemeColors.selectedItemColor,
  selectedColor: ThemeColors.backgroundColor,
  fillColor: ThemeColors.selectedItemColor,
  color: Colors.white,
  constraints: const BoxConstraints(
    minHeight: 36.0,
    minWidth: 75.0,
  ),
  textStyle: const TextStyle(letterSpacing: 0.5, fontSize: 16),
);

FloatingActionButtonThemeData floatingActionButtonThemeData =
    FloatingActionButtonThemeData(
  backgroundColor: ThemeColors.selectedItemColor,
);

AppBarTheme appbarTheme =
    AppBarTheme(backgroundColor: ThemeColors.backgroundColor);

SliderThemeData sliderTheme = SliderThemeData(
    thumbColor: ThemeColors.accentColor,
    activeTrackColor: ThemeColors.primaryColor,
    inactiveTrackColor: ThemeColors.darkPrimaryColor,
    activeTickMarkColor: ThemeColors.backgroundColor,
    inactiveTickMarkColor: ThemeColors.backgroundColor);
