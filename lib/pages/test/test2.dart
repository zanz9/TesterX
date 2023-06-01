import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:testerx/hive/BoxNames.dart';
import 'package:testerx/models/index.dart';

import 'ui/bottom_navigation.dart';
import 'ui/question_body.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    Box lastTestBox = Hive.box(BoxNames.lastTestBox);
    Core core = lastTestBox.get(BoxNames.coreField);
    // TxJson txJsonBefore = TxJson.fromJson(jsonDecode(jsonEncode(core.txJson)));
    if (core.rightList.isEmpty) {
      core.txJson.questions.shuffle(); //* random
      if (!core.maxMode) {
        core.txJson.questions.length = 25;
      }
      for (Questions question in core.txJson.questions) {
        question.answers.shuffle();
      }
    }

    return _Temp(core: core);
  }
}

class _Temp extends StatefulWidget {
  const _Temp({
    required this.core,
  });

  final Core core;

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
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (Route<dynamic> route) => false,
                // arguments: {'core': core, 'finished': false},
              );
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
    SwiperController swiperController = SwiperController();
    ScrollController scrollController = ScrollController();
    int keyCount = 0;

    updateState({VoidCallback? callback}) {
      if (callback != null) {
        callback();
      }
      setState(() {});
    }

    finishTest() {
      var corrects = [...widget.core.rightList];
      corrects.removeWhere((element) => element?.isTrue == false);
      var wrongs = [...widget.core.rightList];
      wrongs.removeWhere((element) => element?.isTrue == true);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ваши результаты'),
          content: Text('''
Правильно - ${corrects.length}
Неправильно - ${wrongs.length}
Всего - ${widget.core.rightList.length}
          '''),
          actions: [
            TextButton(
              onPressed: () {
                var box = Hive.box<Core>('coreBox');
                box.add(widget.core);
                var lastTestBox = Hive.box(BoxNames.lastTestBox);
                lastTestBox.putAll({
                  BoxNames.coreField: widget.core,
                  BoxNames.finishedField: true,
                });
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false,
                    arguments: {
                      'core': Core(
                        widget.core.quizTitle,
                        lastTestBox.get(BoxNames.txJsonBeforeField),
                        widget.core.rightList,
                        widget.core.maxMode,
                      ),
                      'finished': true
                    }); //! DELETE
              },
              child: const Text('Выйти из теста'),
            ),
          ],
        ),
      );
    }

    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (value) {
        if (!value.repeat) {
          keyCount++;
          if (keyCount == 2) {
            keyCount = 0;
            if (value.logicalKey.keyLabel == 'D') {
              swiperController.next();
            }
            if (value.logicalKey.keyLabel == 'A') {
              swiperController.previous();
            }
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.core.quizTitle),
          leading: IconButton(
            onPressed: () {
              willPop(widget.core);
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
          core: widget.core,
          swiperController: swiperController,
          scrollController: scrollController,
        ),
        body: WillPopScope(
          onWillPop: () {
            return willPop(widget.core);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Swiper(
              curve: Curves.ease,
              controller: swiperController,
              itemCount: widget.core.txJson.questions.length,
              itemBuilder: (context, index) => QuestionBody(
                question: widget.core.txJson.questions[index],
                index: index,
                length: widget.core.txJson.questions.length,
                swiperController: swiperController,
                scrollController: scrollController,
                core: widget.core,
                updateState: updateState,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
