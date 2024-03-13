import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

const CALENDAR_LOCALE = "ko_KR";

class Calendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime? selectedDay;
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
      calendarBuilders: CalendarBuilders(
        selectedBuilder: selectedBuilder,
        defaultBuilder: defaultBuilder,
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: selectedDayPredicate,
    );
  }

  bool selectedDayPredicate(DateTime date) {
    if (selectedDay == null) return false;

    return date.year == selectedDay!.year &&
        date.month == selectedDay!.month &&
        date.day == selectedDay!.day;
  }

  Widget defaultDayWidget({
    required DateTime day,
    Color? backgroundColor,
    required TextStyle textStyle,
  }) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        width: DefaultComponent.defaultCalendarDayWidth,
        height: DefaultComponent.defaultCalendarDayHeight,
        child: Center(
          child: Text(
            "${day.day}",
            style: textStyle,
          ),
        ),
      ),
    );
  }

  Widget selectedBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return defaultDayWidget(
      day: day,
      backgroundColor: theme.primaryColor,
      textStyle: textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget defaultBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return defaultDayWidget(
      day: day,
      backgroundColor: ColorResource.LIGHT_GRAY_COLOR,
      textStyle: textTheme.bodyMedium!.copyWith(
        color: defaultColor(day),
      ),
    );
  }

  Color defaultColor(DateTime day) {
    switch (day.weekday) {
      case DateTime.sunday:
        return Colors.red;
      case DateTime.saturday:
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}
