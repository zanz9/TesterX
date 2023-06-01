import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testerx/hive/BoxNames.dart';
import 'package:testerx/models/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var coreBox = Hive.box<ArchiveCore>(BoxNames.coreBox);

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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              coreBox.clear();
            },
            child: const Text('Стереть тесты'),
          ),
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
    );
  }
}
