import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../const/strings.dart';
import '../const/styles.dart';
import '../screen/component/default_component.dart';

class DialogUtil {
  DialogUtil._();

  static void showDateControlDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: DefaultComponent.defaultPaddingSize,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: Styles.dialogButtonStyle,
                    child: const Text(
                      Strings.REPEAT_SCHEDULE_ON_OTHER_DATE,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: Styles.dialogButtonStyle,
                    child: const Text(
                      Strings.CHANGE_SCHEDULE_DATE,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Text(
                      Strings.CLOSE,
                      style: TextStyle(
                        color: ColorResource.BUTTON_NORMAL_COLOR,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
