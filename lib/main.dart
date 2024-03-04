import 'package:flutter/material.dart';
import 'package:news_app/home.dart';
import 'package:news_app/theme/my_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTeme,
      initialRoute: HomePage.initialRoute,
      routes: {
        HomePage.initialRoute: (context) => const HomePage(),
      },
    );
  }
}
