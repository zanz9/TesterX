import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  const Clock({
    super.key,
  });

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String hour = DateTime.now().hour == 24 ? '00' : '';

  String now = DateFormat('HH:mm:ss \n EEE d MMM').format(DateTime.now());
  @override
  initState() {
    super.initState();
    initializeDateFormatting();
    now = DateFormat('HH:mm:ss\nEEEE d MMMM', 'ru').format(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        now = DateFormat('HH:mm:ss\nEEEE d MMMM', 'ru').format(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      now,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
