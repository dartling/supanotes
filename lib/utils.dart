import 'package:flutter/material.dart';

MaterialColor toMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int red = color.red, green = color.green, blue = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      red + ((ds < 0 ? red : (255 - red)) * ds).round(),
      green + ((ds < 0 ? green : (255 - green)) * ds).round(),
      blue + ((ds < 0 ? blue : (255 - blue)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
