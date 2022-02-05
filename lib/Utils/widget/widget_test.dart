import 'package:flutter/material.dart';

Container _shadowButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 10), // changes position of shadow
        ),
      ],
    ),
    child: TextButton(
      child: const Text('some'),
      onPressed: () => {},
    ),
  );
}
