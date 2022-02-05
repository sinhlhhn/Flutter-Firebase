import 'package:flutter/material.dart';

class TestTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200.0,
          height: 100.0,
          color: Colors.green,
          padding: EdgeInsets.all(35),
          margin: EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          child: Text("Hello! I am in the container widget",
              style: TextStyle(fontSize: 25)),
        ),
        Container(
          width: 200.0,
          height: 100.0,
          color: Colors.green,
          padding: EdgeInsets.all(35),
          margin: EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          transform: Matrix4.rotationZ(0.1),
          child: Text("Hello! I am in the container widget",
              style: TextStyle(fontSize: 25)),
        )
      ],
    );
  }
}
