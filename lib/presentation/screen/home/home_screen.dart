import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/calendar.dart';
import 'package:calendar_scheduler/presentation/screen/component/date_banner.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_list_view.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../component/schedule_register_bottom_sheet.dart';

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
        body: Column(
          children: [
            Calendar(
              focusedDay: _selectedDay,
              firstDay: _FIRST_DAY,
              lastDay: _LAST_DAY,
              selectedDay: _selectedDay,
              onDaySelected: onDaySelected,
            ),
            DefaultComponent.defaultHeightSizedBox,
            DateBanner(
              date: _selectedDay,
            ),
            DefaultComponent.defaultHeightSizedBox,
            ScheduleListView(
              date: _selectedDay,
            ),
          ],
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
              selectedDate: DateTime(
                // TODO 라벨에서 오늘 날짜 받아오기
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
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
