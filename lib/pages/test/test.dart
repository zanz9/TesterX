import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:testerx/models/index.dart';
import 'package:testerx/pages/test/ui/bottom_navigation.dart';

import 'ui/question_body.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late String quizTitle;
  late TxJson txJson;
  late bool maxMode;
  List<RightList?> rightList = [];
  bool goRandom = true;

  @override
  void didChangeDependencies() {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    txJson = args['txJson'];
    quizTitle = args['quizTitle'];
    maxMode = args['maxMode'];
    if (args['rightList'] != null) {
      rightList = args['rightList'];
      goRandom = false;
    }
    super.didChangeDependencies();
  }

  Future<bool> willPop(Core core) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Вы действительно хотите выйти?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (Route<dynamic> route) => false,
                arguments: {'core': core, 'finished': false},
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
    SwiperController swiperController = SwiperController();
    ScrollController scrollController = ScrollController();
    int keyCount = 0;
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
      child: _Temp(
        quizTitle: quizTitle,
        txJson: txJson,
        willPop: willPop,
        swiperController: swiperController,
        scrollController: scrollController,
        maxMode: maxMode,
        rightList: rightList,
        goRandom: goRandom,
      ),
    );
  }
}

class _Temp extends StatelessWidget {
  const _Temp({
    required this.quizTitle,
    required this.txJson,
    required this.willPop,
    required this.swiperController,
    required this.scrollController,
    required this.maxMode,
    required this.rightList,
    required this.goRandom,
  });
  final String quizTitle;
  final TxJson txJson;
  final Function willPop;
  final SwiperController swiperController;
  final ScrollController scrollController;
  final bool maxMode;
  final List<RightList?> rightList;
  final bool goRandom;
  @override
  Widget build(BuildContext context) {
    TxJson txJsonBefore = TxJson.fromJson(jsonDecode(jsonEncode(txJson)));
    if (goRandom) {
      txJson.questions.shuffle(); //* random
      if (!maxMode) {
        txJson.questions.length = 25;
      }
      for (Questions question in txJson.questions) {
        question.answers.shuffle();
      }
    }
    return _Temp2(
      quizTitle: quizTitle,
      txJson: txJson,
      willPop: willPop,
      swiperController: swiperController,
      rightList: rightList,
      scrollController: scrollController,
      maxMode: maxMode,
      txJsonBefore: txJsonBefore,
    );
  }
}

class _Temp2 extends StatefulWidget {
  const _Temp2({
    required this.quizTitle,
    required this.txJson,
    required this.willPop,
    required this.swiperController,
    required this.scrollController,
    required this.rightList,
    required this.maxMode,
    required this.txJsonBefore,
  });

  final String quizTitle;
  final TxJson txJsonBefore;
  final TxJson txJson;
  final Function willPop;
  final SwiperController swiperController;
  final ScrollController scrollController;
  final List<RightList?> rightList;
  final bool maxMode;
  @override
  State<_Temp2> createState() => _Temp2State();
}

class _Temp2State extends State<_Temp2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Core core =
        Core(widget.quizTitle, widget.txJson, widget.rightList, widget.maxMode);

    updateState({VoidCallback? callback}) {
      if (callback != null) {
        callback();
      }
      setState(() {});
    }

    finishTest() {
      var corrects = [...widget.rightList];
      corrects.removeWhere((element) => element?.isTrue == false);
      var wrongs = [...widget.rightList];
      wrongs.removeWhere((element) => element?.isTrue == true);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ваши результаты'),
          content: Text('''
Правильно - ${corrects.length}
Неправильно - ${wrongs.length}
Всего - ${widget.rightList.length}
          '''),
          actions: [
            TextButton(
              onPressed: () {
                var box = Hive.box<Core>('coreBox');
                box.add(core);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false,
                    arguments: {
                      'core': Core(
                        widget.quizTitle,
                        widget.txJsonBefore,
                        widget.rightList,
                        widget.maxMode,
                      ),
                      'finished': true
                    });
              },
              child: const Text('Выйти из теста'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quizTitle),
        leading: IconButton(
          onPressed: () {
            widget.willPop(core);
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
          return widget.willPop(core);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Swiper(
            curve: Curves.ease,
            controller: widget.swiperController,
            itemCount: widget.txJson.questions.length,
            itemBuilder: (context, index) => QuestionBody(
              question: widget.txJson.questions[index],
              index: index,
              length: widget.txJson.questions.length,
              swiperController: widget.swiperController,
              scrollController: widget.scrollController,
              core: core,
              updateState: updateState,
            ),
          ),
        ),
      ),
    );
  }
}
