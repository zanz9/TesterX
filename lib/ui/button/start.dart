import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.go('/a');
      },
      backgroundColor: Colors.orange,
      child: const Icon(Icons.output),
    );
  }
}
