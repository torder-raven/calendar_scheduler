import 'package:calendar_scheduler/presentation/const/theme/app_bar_theme.dart';
import 'package:calendar_scheduler/presentation/const/theme/text_theme.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

const _DEFAULT_FONT = "Pretendard";

final calendarTheme = ThemeData(
  fontFamily: _DEFAULT_FONT,
  primaryColor: ColorResource.PRIMARY_COLOR,
  textTheme: textTheme,
  appBarTheme: appBarTheme
);