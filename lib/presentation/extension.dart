import 'package:intl/intl.dart';

extension IntExtension on int {
  String intTimeToTimeString() {
    const minuteInHour = 60;
    const defaultPadString = "0";

    return "${(this ~/ minuteInHour)}:${(this % minuteInHour).toString().padLeft(2, defaultPadString)}";
  }

  String addUnit(String unit) => "$this$unit";
}

extension DateTimeExtension on DateTime {
  String toFormattedString(String format) => DateFormat(format).format(this);

  DateTime toUtcDate() {
    return DateTime.utc(year, month, day);
  }
}
