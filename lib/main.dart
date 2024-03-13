import 'package:calendar_scheduler/di/locator.dart';
import 'package:calendar_scheduler/domain/usecase/register_schedule.dart';
import 'package:calendar_scheduler/presentation/const/theme.dart';
import 'package:calendar_scheduler/presentation/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'domain/entity/schedule.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  initServiceLocator();

  await testFunction();

  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: calendarTheme,
    ),
  );
}

testFunction() async {
  // Schedule schedule = Schedule(
  //   date: DateTime.now(),
  //   startTime: 1,
  //   endTime: 2,
  //   colorCode: 0xFFFFFFFF,
  //   content: "TEST schedule",
  //   id: 0,
  // );
  List<Schedule> schedules = [
    Schedule(
      date: DateTime.now(),
      startTime: 1,
      endTime: 2,
      colorCode: 0xFFFF0000,
      content: "red schedule",
      id: 0,
    ),
    Schedule(
      date: DateTime.now(),
      startTime: 1,
      endTime: 2,
      colorCode: 0xFF00FF00,
      content: "green schedule",
      id: 0,
    ),
    Schedule(
      date: DateTime.now(),
      startTime: 1,
      endTime: 2,
      colorCode: 0xFF00FF00,
      content: "green schedule2",
      id: 0,
    ),
    Schedule(
      date: DateTime.now(),
      startTime: 1,
      endTime: 2,
      colorCode: 0xFF0000FF,
      content: "blue schedule",
      id: 0,
    )
  ];
  Schedule schedule = Schedule(
    date: DateTime.now(),
    startTime: 1,
    endTime: 2,
    colorCode: 0xFF00FF00,
    content: "green schedule3",
    id: 44,
  );
  print("--- registerSchedule ---");
  schedules.forEach(
    (schedule) {
      serviceLocator<RegisterScheduleUsecase>().invoke(schedule: schedule);
    },
  );
}
