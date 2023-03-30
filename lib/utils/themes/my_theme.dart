import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.deepPurple,
      primaryColor: Colors.grey,
      appBarTheme: const AppBarTheme(
        color: Colors.blue,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ));

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
      );
}
