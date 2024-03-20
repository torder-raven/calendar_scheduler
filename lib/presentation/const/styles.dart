import 'package:flutter/material.dart';

import 'colors.dart';

class Styles {
  Styles._();

  static const TextStyle inputLabelTextStyle = TextStyle(
    color: ColorResource.INPUT_TEXT_LABEL_COLOR,
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
  );

  static const TextStyle inputTextStyle = TextStyle(
      color: ColorResource.INPUT_TEXT_FIELD_FILL_COLOR,
      fontWeight: FontWeight.w400,
      fontSize: 13.0);

  static final OutlineInputBorder inputTextOutlineInputBorder =
      OutlineInputBorder(
    borderSide: const BorderSide(
      color: ColorResource.INPUT_TEXT_FIELD_BORDER_COLOR,
    ),
    borderRadius: BorderRadius.circular(8.0),
  );

  static final ButtonStyle normalButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: ColorResource.BUTTON_NORMAL_COLOR,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
  );
}
