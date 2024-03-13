import 'package:calendar_scheduler/presentation/const/strings.dart';
import 'package:flutter/material.dart';

AppBar homeScreenAppBar({
  required ThemeData theme,
  required VoidCallback onDeletePressed,
}) {
  return AppBar(
    title: Text(
      Strings.TITLE,
      style: theme.textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    ),
    backgroundColor: theme.primaryColor,
    actions: [
      IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        onPressed: onDeletePressed,
      ),
    ],
  );
}
