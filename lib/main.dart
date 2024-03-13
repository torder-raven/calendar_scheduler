import 'package:calendar_scheduler/const/theme.dart';
import 'package:calendar_scheduler/data/datasource/drift_database.dart';
import 'package:calendar_scheduler/data/repository/schedule_repository_impl.dart';
import 'package:calendar_scheduler/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  /**
   * 개발을 위한 테스트 코드 (삭제 예정)
   */
  WidgetsFlutterBinding.ensureInitialized();
  ScheduleRepositoryImpl();
  runApp(
    MaterialApp(
      home: const HomeScreen(),
      theme: calendarTheme,
    ),
  );
}
