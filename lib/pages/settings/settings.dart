import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testerx/models/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Core>('coreBox');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // box.add(Core(
            //   'quizTitle',
            //   TxJson(false, [
            //     Questions(
            //       ['title'],
            //       ['rights'],
            //       ['answers'],
            //     )
            //   ]),
            //   [
            //     RightList(index: 1, isTrue: true, selected: [1], title: 'asd')
            //   ],
            //   true,
            // ));
            print(box.values);
          },
          child: const Text('В разработке'),
        ),
      ),
    );
  }
}
