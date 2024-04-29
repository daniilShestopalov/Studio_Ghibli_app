
import 'package:flutter/material.dart';

class ColorParser {
  static final Map<String, Color> _colorMap = {
    "Black": Colors.black,
    "Blue": Colors.blue,
    "Brown": Colors.brown,
    "Grey": Colors.grey,
    "Green": Colors.green,
    "Hazel": const Color.fromARGB(255, 200, 181, 117),
    "White": Colors.white,
    "Blonde": const Color.fromARGB(255, 250, 240, 190),
    "Red": Colors.red,
    "Light Orange": const Color.fromARGB(255, 255, 213, 128),
    "Yellow": Colors.yellow,
    "Emerald": const Color.fromARGB(255, 	80, 200, 120),
    "Beige": const Color.fromARGB(255, 245, 245, 220),
    "Orange": Colors.orange,
  };

  static Color getColorFromString(String colorName) {
     return _colorMap[colorName] ?? Colors.transparent;
  }

  static List<Color> getColorListFromString(String colorsString1, String colorsString2) {
    List<String> colorNames1 = colorsString1.split(',').map((e) => e.trim()).toList();
    List<String> colorNames2 = colorsString2.split(',').map((e) => e.trim()).toList();
    List combinedColorNames = <dynamic>{...colorNames1, ...colorNames2}.toList();
    List<Color> colorList = combinedColorNames.map((colorName) {
      return ColorParser.getColorFromString(colorName);
    }).toList();
    return colorList;
  }
}