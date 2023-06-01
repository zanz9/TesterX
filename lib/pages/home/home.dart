import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testerx/hive/BoxNames.dart';
import 'package:testerx/models/index.dart';

import 'footer.dart';
import 'header.dart';
import 'ui/last_test_container.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Core? core;
  late bool finished;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Box coreBox = Hive.box<ArchiveCore>(BoxNames.coreBox);
    Box lastTestBox = Hive.box(BoxNames.lastTestBox);

    var settingsBox = Hive.box(BoxNames.settingsBox);
    if (settingsBox.keys.isEmpty) {
      settingsBox.putAll({
        BoxNames.maxModeField: false,
      });
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: size.width * 0.05,
            left: size.width * 0.05,
            top: size.width * 0.08,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Header(),
                const SizedBox(height: 50),
                // BODY
                if (!lastTestBox.get(BoxNames.finishedField,
                    defaultValue: true))
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Продолжить тест',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      LastTestContainer(
                        core: lastTestBox.get(BoxNames.coreField),
                        icon: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/test');
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),

                const Row(
                  children: [
                    Text(
                      'Законченные тесты',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                for (ArchiveCore i in coreBox.values.toList().reversed)
                  LastTestContainer(
                    core: i.core,
                    icon: IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        Box settingsBox = Hive.box(BoxNames.settingsBox);
                        bool maxMode = settingsBox.get(BoxNames.maxModeField);
                        lastTestBox.putAll({
                          BoxNames.coreField: Core(
                            i.core.quizTitle,
                            i.initialTxJson,
                            [],
                            maxMode,
                          ),
                          BoxNames.finishedField: false,
                        }).then((value) {
                          Navigator.of(context).pushReplacementNamed('/test');
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
