import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testerx/components/start_test_button.dart';

import 'utils/get_file.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var settingsBox = Hive.box('settingsBox');
    startTest() {
      getFile().then((value) {
        if (value == null) {
          return;
        }
        bool maxMode = settingsBox.get('maxMode');
        Navigator.of(context).pushReplacementNamed('/test', arguments: {
          'txJson': value[0],
          'quizTitle': value[1],
          'rightList': null,
          'maxMode': maxMode,
        });
      });
    }

    return SizedBox(
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
    );
  }
}
