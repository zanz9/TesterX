// ignore_for_file: unused_local_variable

import 'package:hive_flutter/hive_flutter.dart';
import 'package:testerx/models/index.dart';

import 'BoxNames.dart';

Future hiveInitial() async {
  await Hive.initFlutter();

  Hive.registerAdapter(QuestionsAdapter());
  Hive.registerAdapter(TxJsonAdapter());
  Hive.registerAdapter(RightListAdapter());
  Hive.registerAdapter(CoreAdapter());
  Hive.registerAdapter(ArchiveCoreAdapter());

  var box1 = await Hive.openBox<ArchiveCore>(BoxNames.coreBox);
  var box2 = await Hive.openBox(BoxNames.settingsBox);
  var box3 = await Hive.openBox(BoxNames.lastTestBox);
}
