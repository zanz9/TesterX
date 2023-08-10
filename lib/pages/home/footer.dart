import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:testerx/pages/home/ui/start_test_button.dart';
import 'package:testerx/hive/BoxNames.dart';
import 'package:testerx/models/index.dart';
import 'package:testerx/router.dart';

import 'utils/get_file.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var settingsBox = Hive.box(BoxNames.settingsBox);
    startTest() async {
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
        });
        context.goNamed(RouterNames.test.name);
        // Navigator.of(context).pushReplacementNamed('/test');
      });
    }

    return SizedBox(
      height: 120,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
                ? size.width * 0.1
                : 40,
            vertical: 20),
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
