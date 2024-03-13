extension IntExtension on int {
  String intTimeToTimeString() {
  const minuteInHour = 60;
  const defaultPadString = "0";

  return "${(this ~/ minuteInHour)}:${(this % minuteInHour).toString().padLeft(2, defaultPadString)}";
  }
}
