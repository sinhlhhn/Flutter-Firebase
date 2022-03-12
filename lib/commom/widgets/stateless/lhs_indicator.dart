import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LHSIndicator extends StatelessWidget {
  const LHSIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: const CupertinoActivityIndicator(radius: 20),
      ),
    );
  }
}
