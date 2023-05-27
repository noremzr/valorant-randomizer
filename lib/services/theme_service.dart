import 'package:flutter/material.dart';

class ThemeService {
  static ThemeData light() => ThemeData(primarySwatch: Colors.red);

  static ThemeData dark() => ThemeData(primarySwatch: Colors.red,brightness: Brightness.dark);
}
