import 'package:calendar_scheduler/presentation/const/theme.dart';
import 'package:calendar_scheduler/presentation/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initServiceLocator();

  runApp(
    MaterialApp(
      home: const HomeScreen(),
      theme: calendarTheme,
    ),
  );
}
