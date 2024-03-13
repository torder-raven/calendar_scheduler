import 'package:calendar_scheduler/presentation/const/theme.dart';
import 'package:calendar_scheduler/presentation/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: calendarTheme,
    ),
  );
}
