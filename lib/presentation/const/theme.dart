import 'package:flutter/material.dart';

import 'colors.dart';

const _DEFAULT_FONT = "Pretendard";

final calendarTheme = ThemeData(
  fontFamily: _DEFAULT_FONT,
  primaryColor: ColorResource.PRIMARY_COLOR,
  textTheme: defaultTextTheme
);

final defaultTextTheme = TextTheme(
  displayMedium: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black54,
      fontSize: 16.0,
    ),
  displaySmall: TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.black54,
    fontSize: 10.0,
  ),
);