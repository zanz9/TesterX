import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testerx/components/start_test_button.dart';
import 'package:testerx/hive/BoxNames.dart';
import 'package:testerx/models/index.dart';

import 'utils/get_file.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var settingsBox = Hive.box(BoxNames.settingsBox);
    startTest() {
      getFile().then((value) {
        if (value == null) return;

        TxJson txJson = value[0] as TxJson;
        String quizTitle = value[1] as String;
        bool maxMode = settingsBox.get(BoxNames.maxModeField);
        Core core = Core(quizTitle, txJson, [], maxMode);

        Box lastTestBox = Hive.box(BoxNames.lastTestBox);
        lastTestBox.putAll({
          BoxNames.coreField: core,
          BoxNames.finishedField: false,
          BoxNames.tsJsonBeforeField: core.txJson
        });

        Navigator.of(context).pushReplacementNamed('/test', arguments: {
          'txJson': value[0],
          'quizTitle': value[1],
          'rightList': null,
          'maxMode': maxMode,
        });
      });
    }

    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Center(
          child: BottomButton(
            onPressed: startTest,
            text: 'Запустить TesterX',
            icon: Icons.arrow_right_alt_rounded,
          ),
        ),
      ),
    );
  }
}
