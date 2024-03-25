import 'package:calendar_scheduler/di/locator.dart';
import 'package:calendar_scheduler/presentation/const/theme/theme.dart';
import 'package:calendar_scheduler/presentation/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initApp();
  runApp(
    MaterialApp(
      home: const HomeScreen(),
      theme: calendarTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ko', ''),
      ],
    ),
  );
}

initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  initServiceLocator();
}
