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

extension Formatter on String {
  String convertToPngFileFormat() {
    return "asset/img/$this.png";
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedString(String format) => DateFormat(format).format(this);

  DateTime toUtcDate() {
    return DateTime.utc(year, month, day);
  }
}
