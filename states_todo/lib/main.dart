// import 'view.dart';
// import 'core.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isDarkMode = false;

//   void _toggleTheme(bool value) {
//     setState(() {
//       _isDarkMode = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: _isDarkMode
//           ? ThemeData.dark().copyWith(
//               scaffoldBackgroundColor: Colors.black,
//               textTheme: const TextTheme(
//                 bodyLarge: TextStyle(color: Colors.white),
//                 bodyMedium: TextStyle(color: Colors.white),
//                 titleLarge: TextStyle(color: Colors.white),
//               ),
//             )
//           : ThemeData.light(),
//       home: Builder(
//         // important
//         builder: (context) => TodoListScreen(
//           isDarkMode: _isDarkMode,
//           onThemeChanged: _toggleTheme,
//           onOpenSettings: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => SettingsPage(
//                   isDarkMode: _isDarkMode,
//                   onThemeChanged: _toggleTheme,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode; // toggle directly
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                titleLarge: TextStyle(color: Colors.white),
              ),
            )
          : ThemeData.light(),
      home: TodoListScreen(
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

