import 'package:flutter/cupertino.dart';
import '../../const/colors.dart';

class DefaultComponent {
  DefaultComponent._();

  static BoxDecoration defaultCardDecoration = BoxDecoration(
    border: Border.all(
      width: 1.0,
      color: ColorResource.PRIMARY_COLOR,
    ),
    borderRadius: BorderRadius.circular(8.0),
  );

  static SizedBox defaultSizedBox = SizedBox(width: 16.0);
  static EdgeInsets defaultPaddingSize = EdgeInsets.all(20.0);
  static double defaultCircleSize =  16.0;
}
