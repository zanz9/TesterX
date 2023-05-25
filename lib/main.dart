import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'pages/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.orange,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          actionsIconTheme: const IconThemeData(color: Colors.orange),
          iconTheme: const IconThemeData(color: Colors.orange),
          foregroundColor: Colors.orange[200],
        ),
      ),
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => const Home(),
        '/test': (context) => const TestPage(),
        '/settings': (context) => const SettingsPage(),
      },
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
