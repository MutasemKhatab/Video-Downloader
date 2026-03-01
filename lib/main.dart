import 'package:flutter/material.dart';
import 'package:video_downloader/core/di.dart';
import 'package:video_downloader/features/home/presentation/pages/home.dart';

void main() {
  initializeDeps();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Downloader',
      home: HomePage(),
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
