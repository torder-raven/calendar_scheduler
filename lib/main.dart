import 'package:calendar_scheduler/di/locator.dart';
import 'package:calendar_scheduler/presentation/const/theme.dart';
import 'package:calendar_scheduler/presentation/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  initServiceLocator();
  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: calendarTheme,
    ),
  );
}