import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:responsive_framework/responsive_framework.dart';

import 'package:testerx/hive/initial.dart';

import 'colors.dart';
import 'pages/index.dart';

void main() async {
  await hiveInitial();
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
        primarySwatch: primaryColor,
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          actionsIconTheme: IconThemeData(color: primaryColor),
          iconTheme: IconThemeData(color: primaryColor),
          foregroundColor: primaryColor,
        ),
      ),
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => const Home(),
        '/test': (context) => const TestPage(),
        '/settings': (context) => const SettingsPage(),
      },
      scrollBehavior: MyCustomScrollBehavior(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
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
