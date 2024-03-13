extension IntExtension on int {
  String intTimeToTimeString() {
  const minuteInHour = 60;
  const defaultPadString = "0";

  // TODO 이 부분 이렇게 바꿔도 되나요? 시간 부분에 Pad가 적용이 안되는거 같아서요!
  return "${(this ~/ minuteInHour).toString().padLeft(2, defaultPadString)}:${(this % minuteInHour).toString().padLeft(2, defaultPadString)}";
  }
}

extension Formatter on String {
  String convertToPngFileFormat() {
    return "asset/img/$this.png";
  }
}


