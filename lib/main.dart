import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testerx/hive/BoxNames.dart';
import 'package:testerx/hive/initial.dart';

import 'pages/index.dart';

void main() async {
  await hiveInitial();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var box2 = Hive.box(BoxNames.settingsBox);
    if (box2.isEmpty) {
      box2.putAll({
        BoxNames.maxModeField: false,
      });
    }
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
