enum ControlType {
  REPEAT_SCHEDULE_ON_OTHER_DATE("다른 날 또 하기"),
  CHANGE_SCHEDULE_DATE("날짜 바꾸기");

  const ControlType(this.displayName);
  final String displayName;
}