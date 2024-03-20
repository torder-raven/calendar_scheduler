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

  static SizedBox defaultSizedBoxWithWidth = SizedBox(width: 16.0);
  static SizedBox defaultSizedBoxWithHeight = SizedBox(height: 16.0);
  static SizedBox defaultSizedBoxWithHeightSmall = const SizedBox(height: 8.0);
  static EdgeInsets defaultPaddingSize = const EdgeInsets.all(20.0);
  static EdgeInsets defaultSmallPaddingSize = const EdgeInsets.all(10.0);
  static double defaultCircleSize =  16.0;
  static double defaultCalendarDayWidth = 50.0;
  static double defaultCalendarDayHeight = 40.0;
}
