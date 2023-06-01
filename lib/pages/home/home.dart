// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

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
    // ignore: prefer_is_empty
    if (settingsBox.keys.length == 0) {
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
                      Row(
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
                      SizedBox(height: 20),
                      LastTestContainer(
                        core: lastTestBox.get(BoxNames.coreField),
                        icon: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/test');
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),

                Row(
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
                SizedBox(height: 20),
                for (ArchiveCore i in coreBox.values.toList().reversed)
                  LastTestContainer(
                    core: i.core,
                    icon: IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        lastTestBox.putAll({
                          BoxNames.coreField: i.initialTxJson,
                          BoxNames.finishedField: false,
                        });
                        Navigator.of(context).pushReplacementNamed('/test');
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
