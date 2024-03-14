import 'package:flutter/material.dart';

AppBar appBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) {
  final theme = Theme.of(context);
  return AppBar(
    title: Text(
      title ?? "",
      style: theme.textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    ),
    backgroundColor: theme.primaryColor,
    actions: actions,
    iconTheme: const IconThemeData(color: Colors.white),
    centerTitle: true,
  );
}
