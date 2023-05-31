import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testerx/hive/BoxNames.dart';

import 'ui/settings_icon.dart';
import 'utils/get_part_of_the_day.dart';

class Header extends StatefulWidget {
  const Header({
    super.key,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    var settingsBox = Hive.box(BoxNames.settingsBox);
    bool maxMode = settingsBox.get(BoxNames.maxModeField);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getPartOfTheDay(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Image.asset(
                'assets/icon/max.png',
                color: !maxMode ? Colors.white : Colors.orange,
              ),
              onPressed: () {
                setState(() {
                  settingsBox.put('maxMode', !maxMode);
                  // settingsBox.clear();
                });
              },
            ),
            const SizedBox(width: 15),
            IconButton(
              onPressed: () => {
                Navigator.of(context).pushNamed('/settings'),
              },
              icon: const SettingsIcon(),
            ),
          ],
        ),
      ],
    );
  }
}
