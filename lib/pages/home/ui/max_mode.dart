import 'package:flutter/material.dart';

class MaxMode extends StatefulWidget {
  const MaxMode({
    super.key,
    required this.maxMode,
  });
  final List<bool> maxMode;
  @override
  State<MaxMode> createState() => _MaxModeState();
}

class _MaxModeState extends State<MaxMode> {
  @override
  Widget build(BuildContext context) {
    bool pressed = widget.maxMode[0];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOutQuad,
      color: pressed ? Colors.orange : Colors.transparent,
      child: OutlinedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          ),
        ),
        onPressed: () {
          setState(() {
            widget.maxMode[0] = !pressed;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Max Mode',
            style: TextStyle(color: pressed ? Colors.black : Colors.orange),
          ),
        ),
      ),
    );
  }
}
