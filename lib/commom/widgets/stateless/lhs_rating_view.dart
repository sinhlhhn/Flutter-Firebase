import 'package:flutter/material.dart';

class LHSRatingView extends StatelessWidget {
  const LHSRatingView({
    required this.rating,
    Key? key,
  }) : super(key: key);
  final dynamic rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          color: ((rating / 2).round() > index) ? Colors.yellow : Colors.grey,
        );
      }),
    );
  }
}
