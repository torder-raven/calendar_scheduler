import 'package:intl/intl.dart';

extension IntExtension on int {
  String intTimeToTimeString() {
    const minuteInHour = 60;
    const defaultPadString = "0";

    return "${(this ~/ minuteInHour).toString().padLeft(2, defaultPadString)}:${(this % minuteInHour).toString().padLeft(2, defaultPadString)}";
  }

  DateTime intTimeToDateTime() {
    int hour = this ~/ 60;
    int remainingMinutes = this % 60;
    DateTime now = DateTime.now();

    return DateTime(now.year, now.month, now.day, hour, remainingMinutes);
  }

  String addUnit(String unit) => "$this$unit";
}

extension DateTimeExtension on DateTime {
  String toFormattedString(String format) => DateFormat(format).format(this);

  DateTime toUtcDate() {
    return DateTime.utc(year, month, day);
  }

  DateTime firstDayInMonth() {
    return DateTime(year, month, 1);
  }

  DateTime lastDayInMonth() {
    return DateTime(year, month + 1, 0);
  }
}
