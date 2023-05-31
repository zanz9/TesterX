import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testerx/hive/BoxNames.dart';
import 'package:testerx/models/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Core>(BoxNames.coreBox);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              box.clear();
            },
            child: const Text('Стереть тесты'),
          ),
          ElevatedButton(
            onPressed: () {
              box.clear();
              Hive.box(BoxNames.settingsBox).clear();
            },
            child: const Text('Стереть ВСЁ'),
          ),
        ],
      ),
    );
  }
}
