import 'package:flutter/material.dart';

import '../colors.dart';

part 'app_bar_theme.dart';

part 'text_theme.dart';

const _DEFAULT_FONT = "Pretendard";

final calendarTheme = ThemeData(
  fontFamily: _DEFAULT_FONT,
  primaryColor: ColorResource.PRIMARY_COLOR,
  textTheme: textTheme,
  appBarTheme: appBarTheme,
);
