import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testerx/colors.dart';
import 'package:testerx/hive/BoxNames.dart';

import 'package:testerx/models/index.dart';
import 'package:testerx/pages/test/utils/is_right.dart';

class AnswerButton extends StatefulWidget {
  const AnswerButton({
    super.key,
    required this.core,
    required this.index,
    required this.swiperController,
    required this.question,
    required this.updateState,
    required this.scrollController,
  });

  final Core core;
  final Questions question;
  final int index;
  final SwiperController swiperController;
  final ScrollController scrollController;
  final Function updateState;

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    DateTime? currentBackPressTime;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.question.answers.length,
      itemBuilder: (context, i) {
        String? element = widget.question.answers[i];
        RightList? isRightNull = widget.core.rightList.firstWhere(
            (element) => element?.index == widget.index, orElse: () {
          return null;
        });
        EIsRight isRight = isRightCheck(
          widget.core.rightList,
          widget.index,
          i,
          widget.question.rights,
          element,
        );
        Color background;
        if (isRight == EIsRight.blank) {
          background = Colors.transparent;
        } else if (isRight == EIsRight.wrong) {
          background = wrongColor;
        } else {
          background = rightColor;
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          color: background,
          child: OutlinedButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              ),
              // backgroundColor: MaterialStateProperty.all(background),
            ),
            onPressed: () {
              if (isRightNull == null) {
                Box lastTestBox = Hive.box(BoxNames.lastTestBox);
                Core core = lastTestBox.get(BoxNames.coreField);

                var r = RightList(
                  widget.index,
                  widget.question.rights.contains(element),
                  widget.question.title[0],
                  [i],
                );

                setState(() {
                  core.rightList.add(r);
                  lastTestBox.put(BoxNames.coreField, core);
                  // widget.core.rightList.add(r);
                });
                widget.updateState(callback: () {
                  double scroll = widget.scrollController.position.pixels + 63;
                  if (widget.scrollController.position.maxScrollExtent <
                      scroll) {
                    scroll = widget.scrollController.position.maxScrollExtent;
                  }
                  widget.scrollController.animateTo(
                    scroll,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                });
              }

              DateTime now = DateTime.now();
              if (currentBackPressTime == null ||
                  now.difference(currentBackPressTime!) >
                      const Duration(milliseconds: 250)) {
                currentBackPressTime = now;
                return;
              }
              widget.swiperController.next();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle_outlined,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: HtmlWidget(
                            element ?? '',
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
