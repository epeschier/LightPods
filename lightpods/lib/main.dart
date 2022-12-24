import 'package:flutter/material.dart';
import 'package:lightpods/pages/home.dart';
import 'package:lightpods/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: appTheme,
    );
  }
}
