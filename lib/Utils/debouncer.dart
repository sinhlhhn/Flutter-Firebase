import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Debouncer {
  Duration delay;
  Timer? _timer;
  VoidCallback? _callback;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void debounce(VoidCallback callback) {
    _callback = callback;

    cancel();
    _timer = Timer(delay, flush);
  }

  void cancel() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void flush() {
    if (_callback != null) {
      _callback!();
    }
    cancel();
  }
}

class Utils {
  static void showError(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
