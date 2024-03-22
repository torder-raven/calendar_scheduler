import 'package:flutter/material.dart';

class ColorResource {
  ColorResource._();

  static const PRIMARY_COLOR = Color(0xFF0DB2B2);
  static const SECONDARY_COLOR = Color(0xFF800080);
  static final LIGHT_GRAY_COLOR = Colors.grey[200];
  static final DARK_GRAY_COLOR = Colors.grey[600];
  static final TEXT_FIELD_FILL_COLOR = Colors.grey[300];

  static const INPUT_TEXT_LABEL_COLOR = Color(0xFF6B718A);
  static const INPUT_TEXT_FIELD_FILL_COLOR = Colors.black;
  static const INPUT_TEXT_FIELD_BORDER_COLOR = Color(0xFFE5E6EB);
  static const INPUT_TEXT_FIELD_HINT_COLOR = Color(0xFFABAFBF);
  static const BUTTON_NORMAL_COLOR = Color(0xFF262831);

  static const SELECT_COLOR_RED = Colors.red;
  static const SELECT_COLOR_ORANGE = Colors.orange;
  static const SELECT_COLOR_YELLOW = Colors.yellow;
  static const SELECT_COLOR_GREEN = Colors.green;
  static const SELECT_COLOR_BLUE = Colors.blue;
  static const SELECT_COLOR_INDIGO = Colors.indigo;
  static const SELECT_COLOR_PURPLE = Colors.purple;

  static const List<Color> selectorColors = [
    ColorResource.SELECT_COLOR_RED,
    ColorResource.SELECT_COLOR_ORANGE,
    ColorResource.SELECT_COLOR_YELLOW,
    ColorResource.SELECT_COLOR_GREEN,
    ColorResource.SELECT_COLOR_BLUE,
    ColorResource.SELECT_COLOR_INDIGO,
    ColorResource.SELECT_COLOR_PURPLE,
  ];
}
