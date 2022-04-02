import 'package:flutter/material.dart';

class LHSSnackBarChild extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final TextStyle textStyle;

  const LHSSnackBarChild(
      {required this.text,
      required this.backgroundColor,
      required this.textStyle,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: DefaultTextStyle(
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
        style: textStyle,
      ),
    );
  }
}
