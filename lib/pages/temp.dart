import 'package:flutter/material.dart';
import 'package:testerx/ui/button/start.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI Template'), centerTitle: true),
      floatingActionButton: const StartButton(),
    );
  }
}
