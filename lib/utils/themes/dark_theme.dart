import 'package:flutter/material.dart';
ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black26,
  );
}
