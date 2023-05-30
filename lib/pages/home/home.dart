import 'package:flutter/material.dart';
import 'package:testerx/models/index.dart';

import 'footer.dart';
import 'header.dart';

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

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.width * 0.08,
          ),
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: 50),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
