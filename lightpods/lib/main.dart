import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io' show Platform;
import 'package:get_it/get_it.dart';
import 'package:lightpods/pages/home.dart';
import 'package:lightpods/services/pod_service.dart';
import 'package:lightpods/theme/theme.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  GetIt.I.registerLazySingleton<PodService>(() => PodService());
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    Wakelock.enable();
  }

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
