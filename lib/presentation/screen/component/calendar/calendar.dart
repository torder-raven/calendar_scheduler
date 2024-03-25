import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:calendar_scheduler/presentation/screen/component/calendar/provider/calendar_provider.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../domain/entity/schedule.dart';

part 'default_builder.dart';

part 'default_day.dart';

part 'marker_builder.dart';

part 'selected_builder.dart';

const CALENDAR_LOCALE = "ko_KR";

class Calendar extends StatelessWidget {
  final DateTime firstDay;
  final DateTime lastDay;

  const Calendar({
    super.key,
    required this.firstDay,
    required this.lastDay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return StreamBuilder<Map<DateTime, List<Schedule>>>(
      stream: context.read<CalendarProvider>().scheduleStream(),
      builder: (context, snapshot) {
        final scheduleMap = snapshot.data;
        return TableCalendar(
          locale: CALENDAR_LOCALE,
          focusedDay: context.read<CalendarProvider>().focusedDay,
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
            markerBuilder: _markerBuilder,
          ),
          eventLoader: (day) => scheduleMap?[day] ?? [],
          onDaySelected: (selectedDay, _) =>
              context.read<CalendarProvider>().updateSelectedDay(selectedDay),
          onPageChanged: (date) {
            context.read<CalendarProvider>().updateFocusedDay(date);
          },
          selectedDayPredicate: (DateTime date) => selectedDayPredicate(
            context: context,
            date: date,
          ),
        );
      }
    );
  }

  bool selectedDayPredicate({
    required BuildContext context,
    required DateTime date,
  }) {
    final selectedDay = context.read<CalendarProvider>().selectedDay;

    return date.year == selectedDay.year &&
        date.month == selectedDay.month &&
        date.day == selectedDay.day;
  }
}
