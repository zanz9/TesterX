import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:testerx/hive/BoxNames.dart';
import 'package:testerx/models/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var coreBox = Hive.box<ArchiveCore>(BoxNames.coreBox);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
          icon: const Icon(Icons.arrow_circle_left_outlined),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: size.width * 0.05,
          left: size.width * 0.05,
          top: (ResponsiveBreakpoints.of(context).largerThan(TABLET))
              ? 60
              : size.width * 0.08,
        ),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                coreBox.clear();
              },
              child: const Text('Стереть тесты'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                coreBox.clear();
                Hive.box(BoxNames.settingsBox).clear();
                Hive.box(BoxNames.lastTestBox).clear();
              },
              child: const Text('Стереть ВСЁ'),
            ),
          ],
        ),
      ),
    );
  }
}
