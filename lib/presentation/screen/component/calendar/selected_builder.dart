part of 'calendar.dart';

Widget _selectedBuilder(
  BuildContext context,
  DateTime day,
  DateTime focusedDay,
) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;

  return _DefaultDay(
    day: day,
    backgroundColor: theme.primaryColor,
    textStyle: textTheme.bodyMedium!.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  );
}
