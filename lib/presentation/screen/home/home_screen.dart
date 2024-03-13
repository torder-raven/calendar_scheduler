import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../component/schedule_register_bottom_sheet.dart';
import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/calendar.dart';

final _FIRST_DAY = DateTime.utc(1900);
final _LAST_DAY = DateTime.utc(3000);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDay = DateTime.now().toUtcDate();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: renderFloatingActionButton(),
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
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          builder: (_) {
            return ScheduleRegisterBottomSheet(
              selectedDate: _selectedDay
            );
          },
        );
      },
      backgroundColor: ColorResource.PRIMARY_COLOR,
      child: Icon(Icons.add),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }
}
