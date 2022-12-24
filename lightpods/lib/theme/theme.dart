import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  //primarySwatch: MaterialColor. Color(0xff607D8B);
  brightness: Brightness.dark,
  useMaterial3: false,
  bottomNavigationBarTheme: bottomNavigationBarTheme,
);

BottomNavigationBarThemeData bottomNavigationBarTheme =
    const BottomNavigationBarThemeData(
  backgroundColor: Color.fromARGB(255, 34, 44, 49),
  selectedItemColor: Color.fromARGB(255, 251, 215, 52),
  unselectedItemColor: Color.fromARGB(255, 96, 125, 139),
  showSelectedLabels: false,
  showUnselectedLabels: false,
);

ButtonStyle toggleButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.lightBlue[800],
    shape: const CircleBorder(),
    padding: const EdgeInsets.all(20),
    textStyle: TextStyle(
        color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 40));
