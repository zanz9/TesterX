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
  void didChangeDependencies() {
    //! Сделать новый бокс и хранить кор и финишед там, чтобы при перезапуске приложения сохранялась последняя сессия
    final Map? args = ModalRoute.of(context)!.settings.arguments as Map?;
    if (args != null) {
      core = args['core'];
      finished = args['finished'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<bool> maxMode = [core?.maxMode ?? false];

    Box coreBox = Hive.box<Core>(BoxNames.coreBox);
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
                if (core != null)
                  SizedBox(
                    height: 60,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/test', arguments: {
                          'txJson': core!.txJson,
                          'quizTitle': core!.quizTitle,
                          'rightList': !finished ? core!.rightList : null,
                          'maxMode': maxMode[0],
                        });
                      },
                      child: Text(
                          finished ? 'Пройти тест заново' : 'Продолжить тест'),
                    ),
                  ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'Последние тесты',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                for (Core i in coreBox.values.toList().reversed)
                  LastTestContainer(core: i),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
