import 'package:flutter/material.dart';

import '../../const/styles.dart';

class CustomDatePicker extends StatelessWidget {
  final Widget dialogContent;
  final Widget cancelButton;
  final Widget confirmButton;

  CustomDatePicker({
    required this.dialogContent,
    required this.cancelButton,
    required this.confirmButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: Styles.dialogTopRadiusBoxStyle,
                height: 200,
                child: dialogContent,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
              ),
              decoration: Styles.dialogBottomRadiusBoxStyle,
              child: Row(
                children: [
                  cancelButton,
                  const SizedBox(
                    width: 8,
                  ),
                  confirmButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
