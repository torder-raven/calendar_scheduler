import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:flutter/material.dart';

import '../../../../../di/locator.dart';
import '../../../../../domain/entity/schedule.dart';
import '../../../../../domain/usecase/get_schedule_between_day.dart';

class CalendarProvider with ChangeNotifier {
  DateTime _selectedDay = DateTime.now().toUtcDate();

  DateTime get selectedDay => _selectedDay;

  DateTime _focusedDay = DateTime.now().toUtcDate();

  DateTime get focusedDay => _focusedDay;

  Map<DateTime, List<Schedule>> _scheduleMap = {};

  Map<DateTime, List<Schedule>> get scheduleMap => _scheduleMap;

  CalendarProvider() {
    updateEvents();
  }

  updateSelectedDay(DateTime newDay) {
    _selectedDay = newDay;
    notifyListeners();
  }

  updateFocusedDay(DateTime newDay) {
    _focusedDay = newDay;
  }

  updateEvents() async {
    _scheduleMap = await serviceLocator<GetScheduleBetweenDayUsecase>().invoke(
      startDay: DateTime(_focusedDay.year, _focusedDay.month, 1),
      endDay: DateTime(_focusedDay.year, _focusedDay.month + 1, 0, 23, 59, 59),
    );

    notifyListeners();
  }
}
