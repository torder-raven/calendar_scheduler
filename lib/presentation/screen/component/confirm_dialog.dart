import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../const/colors.dart';
import '../../const/strings.dart';

Future<bool?> androidDialog({
  required VoidCallback onConfirm,
  required String title,
  required BuildContext context,
}) {
  return showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: ColorResource.BUTTON_NORMAL_COLOR),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(Strings.CANCEL),
            ),
            TextButton(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop(true);
                },
                child: Text(Strings.DELETE)),
          ],
        );
      });
}

Future<bool?> iosDialog({
  required VoidCallback onConfirm,
  required String title,
  required BuildContext context,
}) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: ColorResource.BUTTON_NORMAL_COLOR),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(Strings.CANCEL),
          ),
          TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop(true);
              },
              child: Text(Strings.DELETE)),
        ],
      );
    },
  );
}
