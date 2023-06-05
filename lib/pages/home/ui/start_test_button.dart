import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              text,
              style: TextStyle(
                  fontSize:
                      (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
                          ? 24
                          : 20,
                  fontWeight: FontWeight.w600),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
