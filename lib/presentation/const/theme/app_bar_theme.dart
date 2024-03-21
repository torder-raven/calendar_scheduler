import 'package:flutter/material.dart';

import '../colors.dart';

AppBarTheme appBarTheme = const AppBarTheme(
  titleTextStyle: TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  ),
  backgroundColor: ColorResource.PRIMARY_COLOR,
  iconTheme: IconThemeData(color: Colors.white),
  centerTitle: true,
);
