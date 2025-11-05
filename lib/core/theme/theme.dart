import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
  ),
);

extension ThemeContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
