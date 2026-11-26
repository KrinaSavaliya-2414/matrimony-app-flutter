import 'package:flutter/material.dart';

import 'splash_screen.dart';
import 'user_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserData.loadUsers();

  runApp(const VivaahVerseApp());
}

class VivaahVerseApp extends StatelessWidget {
  const VivaahVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "VivaahVerse",
      home: const SplashScreen(),
    );
  }
}