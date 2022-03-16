import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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

  void test() {
    // final constructor = Constructor("nil");
  }
}

class Constructor {
  // final string;
}

Future<String> get _localPath async {
  print((await getApplicationSupportDirectory()).path);
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  print('path ${path}');
  return File('$path');
}

Future<void> deleteFile() async {
  try {
    final file = await _localFile;
    // file.delete(recursive: true);
  } catch (e) {
    print("error: $e");
  }
}
