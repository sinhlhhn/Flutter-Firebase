import 'package:flutter/material.dart';

import '../Screen/test_screen/home_tab.dart';

testFinalAndConst() {
  const newConst = [1, 2, 3];
  final newFinal = [1, 2, 3];

  newConst[0] = 2;
  newFinal[0] = 2;

  var coin = CoinModel("name", "value", "icon");
  coin = CoinModel("name", "value", "icon");
}

void test() {
  final c = CoinModel("name", "value", "icon");
  final a = testFinalAndConst();
}

class AppStyles {
  static const h3 = TextStyle(fontSize: 32);
}
