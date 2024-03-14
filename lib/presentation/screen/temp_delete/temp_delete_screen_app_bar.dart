import 'package:calendar_scheduler/presentation/const/strings.dart';
import 'package:flutter/material.dart';
import 'dart:io';

AppBar tempDeleteScreenAppBar({
  required ThemeData theme,
  required VoidCallback backPressed,
}) {
  return AppBar(
    title: Text(
      Strings.TEMP_DELETE_TITLE,
      style: theme.textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    ),
    backgroundColor: theme.primaryColor,
  );
}
