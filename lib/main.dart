import 'package:calendar_scheduler/di/locator.dart';
import 'package:calendar_scheduler/presentation/const/theme/theme.dart';
import 'package:calendar_scheduler/presentation/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initApp();
  runApp(
    MaterialApp(
      home: const HomeScreen(),
      theme: calendarTheme,
    ),
  );
}

initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  initServiceLocator();
}
