import 'package:flutter/material.dart';
import 'package:testerx/models/index.dart';

class LastTestContainer extends StatelessWidget {
  const LastTestContainer({
    super.key,
    required this.core,
    required this.icon,
  });

  final Core core;
  final IconButton icon;

  @override
  Widget build(BuildContext context) {
    var corrects = [...core.rightList];
    corrects.removeWhere((element) => element?.isTrue == false);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(66, 52, 52, 52),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                    boxShadow: const [
                      BoxShadow(color: Colors.green, spreadRadius: 3),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    corrects.length.toString(),
                    style: const TextStyle(fontSize: 18),
                  )),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      core.quizTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${core.rightList.length}/${core.txJson.questions.length} Вопросов',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                )
              ],
            ),
            icon
          ],
        ),
      ),
    );
  }
}
