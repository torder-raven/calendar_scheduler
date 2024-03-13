import 'package:calendar_scheduler/presentation/screen/component/calendar.dart';
import 'package:calendar_scheduler/presentation/screen/temp_delete/temp_delete_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen_appbar.dart';

final _FIRST_DAY = DateTime.utc(1900);
final _LAST_DAY = DateTime.utc(3000);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: homeScreenAppBar(
        theme: theme,
        onDeletePressed: goToTempDeleteScreen,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              focusedDay: _selectedDay,
              firstDay: _FIRST_DAY,
              lastDay: _LAST_DAY,
              selectedDay: _selectedDay,
              onDaySelected: onDaySelected,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goToTempDeleteScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const TempDeleteScreen();
    }));
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }
}
