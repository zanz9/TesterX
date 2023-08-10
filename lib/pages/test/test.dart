import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keymap/keymap.dart';

import 'package:testerx/hive/BoxNames.dart';
import 'package:testerx/models/index.dart';
import 'package:testerx/router.dart';

import 'ui/bottom_navigation.dart';
import 'ui/question_body.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    SwiperController swiperController = SwiperController();
    ScrollController scrollController = ScrollController();
    Box lastTestBox = Hive.box(BoxNames.lastTestBox);
    Core core = lastTestBox.get(BoxNames.coreField);
    TxJson initialTxJson = TxJson.fromJson(jsonDecode(jsonEncode(core.txJson)));
    lastTestBox.put(BoxNames.txJsonBeforeField, initialTxJson);
    if (core.rightList.isEmpty) {
      core.txJson.questions.shuffle(); //* random
      if (!core.maxMode) {
        core.txJson.questions.length = 25;
      }
      for (Questions question in core.txJson.questions) {
        question.answers.shuffle();
      }
    }

    return _Temp(
      archiveCore: ArchiveCore(core, initialTxJson),
      swiperController: swiperController,
      scrollController: scrollController,
    );
  }
}

class _Temp extends StatefulWidget {
  const _Temp({
    required this.archiveCore,
    required this.swiperController,
    required this.scrollController,
  });

  final ArchiveCore archiveCore;
  final SwiperController swiperController;
  final ScrollController scrollController;
  @override
  State<_Temp> createState() => _TempState();
}

class _TempState extends State<_Temp> {
  Future<bool> willPop(Core core) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Вы действительно хотите выйти?'),
        actions: [
          TextButton(
            onPressed: () {
              var lastTestBox = Hive.box(BoxNames.lastTestBox);
              lastTestBox.putAll({
                BoxNames.coreField: core,
                BoxNames.finishedField: false,
              });
              context.goNamed(RouterNames.home.name);
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   '/',
              //   (Route<dynamic> route) => false,
              // );
            },
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Core core = widget.archiveCore.core;

    updateState({VoidCallback? callback}) {
      if (callback != null) {
        callback();
      }
      setState(() {});
    }

    finishTest() {
      var corrects = [...core.rightList];
      corrects.removeWhere((element) => element?.isTrue == false);
      var wrongs = [...core.rightList];
      wrongs.removeWhere((element) => element?.isTrue == true);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ваши результаты'),
          content: Text('''
Правильно - ${corrects.length}
Неправильно - ${wrongs.length}
Всего - ${core.rightList.length}
          '''),
          actions: [
            TextButton(
              onPressed: () async {
                var coreBox = Hive.box<ArchiveCore>('coreBox');
                coreBox.add(widget.archiveCore);
                await Hive.box(BoxNames.lastTestBox).clear();
                context.goNamed(RouterNames.home.name);
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     '/', (Route<dynamic> route) => false);
              },
              child: const Text('Выйти из теста'),
            ),
          ],
        ),
      );
    }

    return KeyboardWidget(
      bindings: [
        KeyAction(LogicalKeyboardKey.keyD, 'Следущий вопрос', () {
          widget.swiperController.next();
        }),
        KeyAction(LogicalKeyboardKey.keyA, 'Предыдущий вопрос', () {
          widget.swiperController.previous();
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(core.quizTitle),
          leading: IconButton(
            onPressed: () {
              willPop(core);
            },
            icon: const Icon(Icons.arrow_circle_left_outlined),
          ),
          actions: [
            IconButton(
              onPressed: () {
                finishTest();
              },
              icon: const Icon(Icons.exit_to_app_outlined),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          size: size,
          core: core,
          swiperController: widget.swiperController,
          scrollController: widget.scrollController,
        ),
        body: WillPopScope(
          onWillPop: () {
            return willPop(core);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Swiper(
              curve: Curves.ease,
              controller: widget.swiperController,
              itemCount: core.txJson.questions.length,
              itemBuilder: (context, index) => QuestionBody(
                question: core.txJson.questions[index],
                index: index,
                length: core.txJson.questions.length,
                swiperController: widget.swiperController,
                scrollController: widget.scrollController,
                core: core,
                updateState: updateState,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
