import 'package:calendar_scheduler/presentation/const/strings.dart';
import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/calendar.dart';
import 'package:calendar_scheduler/presentation/screen/component/date_banner.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_list_view.dart';
import 'package:calendar_scheduler/presentation/screen/filter_screen/schedule_filter_screen.dart';
import 'package:calendar_scheduler/presentation/screen/temp_delete/temp_delete_screen.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../const/strings.dart';
import '../component/schedule_register_bottom_sheet.dart';
part 'home_app_bar.dart';

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
    return Scaffold(
      appBar: _homeAppBar(
        onFilterPressed: goToFilterScheduleScreen,
        onDeletePressed: goToTempDeleteScreen,
      ),
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
            DefaultComponent.defaultSizedBoxWithHeightSmall,
            DateBanner(
              date: _selectedDay,
            ),
            DefaultComponent.defaultSizedBoxWithHeightSmall,
            ScheduleListView(
              date: _selectedDay,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goToFilterScheduleScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ScheduleFilterScreen();
    }));
  }

  void goToTempDeleteScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const TempDeleteScreen();
    }));
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
              selectedDate: _selectedDay,
            );
          },
        );
      },
      backgroundColor: ColorResource.PRIMARY_COLOR,
      child: Icon(Icons.add),
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }
}
