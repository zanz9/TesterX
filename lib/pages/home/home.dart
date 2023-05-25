import 'package:flutter/material.dart';
import 'package:testerx/components/start_test_button.dart';
import 'package:testerx/models/index.dart';
import 'package:testerx/pages/home/ui/settings_icon.dart';

import 'ui/body_container.dart';
import 'ui/clock.dart';
import 'utils/get_file.dart';

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

    startTest() {
      getFile().then((value) {
        if (value == null) {
          return;
        }
        Navigator.of(context).pushReplacementNamed('/test', arguments: {
          'txJson': value[0],
          'quizTitle': value[1],
          'rightList': null,
          'maxMode': maxMode[0],
        });
      });
    }

    int hour = DateTime.now().hour;
    String partOfTheDay;
    if (6 <= hour && hour < 12) {
      partOfTheDay = 'morning';
    } else if (12 <= hour && hour < 18) {
      partOfTheDay = 'evening';
    } else if (18 <= hour && hour < 22) {
      partOfTheDay = 'afternoon';
    } else {
      partOfTheDay = 'night';
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.width * 0.08,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Good $partOfTheDay!',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => {
                      Navigator.of(context).pushNamed('/settings'),
                    },
                    icon: const SettingsIcon(),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BodyContainer(
                    w: Clock(),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              MaxMode(maxMode: maxMode),
              const SizedBox(height: 25),
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
                      finished ? 'Пройти тест заново' : 'Продолжить тест',
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: size.height * 0.25,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomButton(
                onPressed: startTest,
                text: 'Запустить TesterX',
                icon: Icons.arrow_right_alt_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaxMode extends StatefulWidget {
  const MaxMode({
    super.key,
    required this.maxMode,
  });
  final List<bool> maxMode;
  @override
  State<MaxMode> createState() => _MaxModeState();
}

class _MaxModeState extends State<MaxMode> {
  @override
  Widget build(BuildContext context) {
    bool pressed = widget.maxMode[0];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOutQuad,
      color: pressed ? Colors.orange : Colors.transparent,
      child: OutlinedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          ),
        ),
        onPressed: () {
          setState(() {
            widget.maxMode[0] = !pressed;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Max Mode',
            style: TextStyle(color: pressed ? Colors.black : Colors.orange),
          ),
        ),
      ),
    );
  }
}
