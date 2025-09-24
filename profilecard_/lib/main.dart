import 'package:flutter/material.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MyApp());
}

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    secondary: const Color.fromARGB(255, 55, 55, 55),
    inversePrimary: Colors.grey.shade300,
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: darkMode,
      home: const HomeView(),
    );
  }
}

