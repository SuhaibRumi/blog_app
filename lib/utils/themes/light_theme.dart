import 'package:flutter/material.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: Colors.grey[200],
    scaffoldBackgroundColor: Colors.grey[100],
  );
}
