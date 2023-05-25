import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:testerx/models/index.dart';

import 'answer_body.dart';

class QuestionBody extends StatelessWidget {
  const QuestionBody({
    super.key,
    required this.question,
    required this.index,
    required this.length,
    required this.swiperController,
    required this.core,
    required this.updateState,
    required this.scrollController,
  });

  final Questions question;
  final int index, length;
  final SwiperController swiperController;
  final ScrollController scrollController;
  final Core core;
  final Function updateState;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            Row(
              children: [
                Text(
                  'Вопрос ${index + 1} из $length',
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Flexible(
                  child: HtmlWidget(
                    question.title[0] ?? '',
                    textStyle: const TextStyle(fontSize: 28),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            AnswerButton(
              core: core,
              index: index,
              question: question,
              swiperController: swiperController,
              updateState: updateState,
              scrollController: scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
