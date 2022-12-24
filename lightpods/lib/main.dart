import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/pages/home.dart';
import 'package:lightpods/pod_service.dart';
import 'package:lightpods/theme/theme.dart';

void main() {
  GetIt.I.registerLazySingleton<PodService>(() => PodService());
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
