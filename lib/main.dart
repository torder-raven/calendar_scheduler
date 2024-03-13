import 'package:calendar_scheduler/const/theme.dart';
import 'package:calendar_scheduler/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: const HomeScreen(),
      theme: calendarTheme,
    ),
  );
}
