import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:testerx/models/index.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
    required this.size,
    required this.core,
    required this.swiperController,
    required this.scrollController,
  });

  final Size size;
  final Core core;
  final SwiperController swiperController;
  final ScrollController scrollController;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: widget.size.height * 0.02),
      height: widget.size.height * 0.1,
      child: ListView.builder(
        controller: widget.scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.core.txJson.questions.length,
        itemBuilder: (context, index) {
          Color background = Colors.transparent;
          final isRight = widget.core.rightList.firstWhere(
            (el) => el?.index == index,
            orElse: () {
              return null;
            },
          );
          if (isRight == null) {
            background = Colors.transparent;
          } else if (isRight.isTrue == true) {
            background = Colors.green;
          } else {
            background = Colors.red;
          }
          return Container(
            margin: const EdgeInsets.only(right: 7),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              color: background,
              child: OutlinedButton(
                onPressed: () {
                  widget.swiperController.move(index);
                },
                child: Text('${index + 1}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
