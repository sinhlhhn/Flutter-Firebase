import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../Screen/test_screen/home_tab.dart';

SizedBox addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

ImageProvider<Object>? _getBackgroundImage(String imagePath) {
  if (imagePath.isNotEmpty) {
    print(imagePath);
    return FileImage(File(imagePath));
  } else {
    return null;
  }
}

/// `test`
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

void createRecord() async {
  final app = await Firebase.initializeApp();
  DatabaseReference ref = FirebaseDatabase.instanceFor(
          app: app,
          databaseURL:
              "https://flutter-firebase-d5927-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref();

  final id = ref.child("posts");
  print(id.child("posts"));
  await id.set({"name": "John"});

  print("Done");
  ref.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    print(data);
  });
}

void testThrow() async {
  print("Start");
  final imagePath =
      "/Users/lehoangsinh/Library/Developer/CoreSimulator/Devices/218CC963-C322-4DEC-82CB-D8E6CD7C6C54/data/Containers/Data/Application/F217E23F-FAEF-452A-AE8E-D6F1D2C92DED/tmp/new.jpg";
  final email = "a@a.com";
  final file = File(imagePath);

  final ref = FirebaseStorage.instance
      .ref()
      .child(email)
      .child("profile")
      .child("avatar");

  final data = file.readAsBytesSync();

  await ref.putData(data);
  // await ref.putFile(file);
  print("Done");
}

void testThrow2() {
  print("Show2");
  try {
    testThrow3();
    print("not show2");
  } catch (e) {
    rethrow;
  }
}

void testThrow3() {
  print("Show3");
  throw "Error";
}
