import 'dart:async';

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

  void updateSelectedDay(DateTime newDay) {
    _selectedDay = newDay;
    notifyListeners();
  }

  void updateFocusedDay(DateTime newDay) {
    _focusedDay = newDay;
    notifyListeners();
  }

  Stream<Map<DateTime, List<Schedule>>> scheduleStream() {
    return serviceLocator<GetScheduleBetweenDayUsecase>().invoke(
      startDay: _focusedDay.firstDayInMonth(),
      endDay: _focusedDay.lastDayInMonth(),
    );
  }
}
