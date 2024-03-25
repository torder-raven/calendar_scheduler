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

  static final ButtonStyle dialogButtonStyle = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    elevation: 0, backgroundColor: ColorResource.PRIMARY_COLOR, // 변경된 부분
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
  );

  static final ButtonStyle confirmButtonStyle = dialogButtonStyle;
  static final ButtonStyle cancelButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.circular(6.0),
    ),
  );

  static const dialogTopRadiusBoxStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  );

  static const dialogBottomRadiusBoxStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
    ),
  );
}
