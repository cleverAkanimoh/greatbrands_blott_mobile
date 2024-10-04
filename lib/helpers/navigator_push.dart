import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class NavigatorPush {
  static push(context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static pushRemoveUntil({page}) {
    OneContext().navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  static pushReplace({page}) {
    OneContext()
        .navigator
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
}
