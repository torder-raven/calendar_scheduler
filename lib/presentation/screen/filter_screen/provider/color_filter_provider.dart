import 'package:flutter/material.dart';

import '../../../../di/locator.dart';
import '../../../../domain/entity/schedule.dart';
import '../../../../domain/usecase/get_schedule_by_color.dart';
import '../../../const/colors.dart';

class ColorFilterProvider with ChangeNotifier {
  final colors = ColorResource.selectorColors;
  late int _selectedColorId;

  int get selectedColorId => _selectedColorId;

  ColorFilterProvider() {
    _selectedColorId = colors[0].value;
  }

  void updateSelectedColorId(int id) {
    _selectedColorId = id;
    notifyListeners();
  }

  Future<List<Schedule>> getScheduleByColor() async {
    return await serviceLocator<GetScheduleByColorUsecase>()
        .invoke(colorCode: selectedColorId);
  }
}
