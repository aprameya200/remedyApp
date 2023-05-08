import 'package:flutter/material.dart';

import '../main.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  getKey() {
    return messengerKey;
  }

  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.deepOrange,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
