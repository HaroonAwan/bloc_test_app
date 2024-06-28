import 'package:flutter/material.dart';

/// A class to handle the navigation of the app

sealed class AppNavigation {
  static Future<void> toPage(BuildContext context, Widget page) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  static void pop(BuildContext context) {
    return Navigator.of(context).pop();
  }
}
