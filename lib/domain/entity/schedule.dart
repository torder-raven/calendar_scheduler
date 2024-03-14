class Schedule {
  static const DEFAULT_ID_VALUE = -1;

  final String content;
  final DateTime date;
  final int startTime;
  final int endTime;
  final int colorCode;
  final int id;

  Schedule({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.colorCode,
    required this.content,
    this.id = DEFAULT_ID_VALUE,
  });
}
