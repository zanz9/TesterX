import 'package:flutter/material.dart';

class SettingsIcon extends StatefulWidget {
  const SettingsIcon({
    super.key,
  });

  @override
  State<SettingsIcon> createState() => _SettingsIconState();
}

class _SettingsIconState extends State<SettingsIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: const Icon(Icons.settings),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
