part of 'calendar.dart';

Widget _defaultBuilder(
  BuildContext context,
  DateTime day,
  DateTime focusedDay,
) {
  final textTheme = Theme.of(context).textTheme;

  return _DefaultDay(
    day: day,
    backgroundColor: ColorResource.LIGHT_GRAY_COLOR,
    textStyle: textTheme.bodyMedium!.copyWith(
      color: _defaultColor(day),
    ),
  );
}

Color _defaultColor(DateTime day) {
  switch (day.weekday) {
    case DateTime.sunday:
      return Colors.red;
    case DateTime.saturday:
      return Colors.blue;
    default:
      return Colors.black;
  }
}
