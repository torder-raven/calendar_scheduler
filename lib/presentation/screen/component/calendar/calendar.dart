import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

part 'default_builder.dart';

part 'default_day.dart';

part 'selected_builder.dart';

const CALENDAR_LOCALE = "ko_KR";

class Calendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime selectedDay;
  final OnDaySelected onDaySelected;

  const Calendar({
    super.key,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return TableCalendar(
      locale: CALENDAR_LOCALE,
      focusedDay: focusedDay,
      firstDay: firstDay,
      lastDay: lastDay,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: textTheme.titleMedium!,
      ),
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: false,
      ),
      calendarBuilders: const CalendarBuilders(
        selectedBuilder: _selectedBuilder,
        defaultBuilder: _defaultBuilder,
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: selectedDayPredicate,
    );
  }

  bool selectedDayPredicate(DateTime date) {
    return date.year == selectedDay.year &&
        date.month == selectedDay.month &&
        date.day == selectedDay.day;
  }
}
