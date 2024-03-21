import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:flutter/cupertino.dart';

class ScheduleProvider with ChangeNotifier {
  int _currentId = 0;
  int get currentId => _currentId;

  DateTime _currentDateTime = DateTime.now();
  DateTime get currentDateTime => _currentDateTime;

  int _currentStartTime = 0;
  int get currentStartTime => _currentStartTime;

  int _currentEndTime = 0;
  int get currentEndTime => _currentEndTime;

  int _currentSelectedColorId = ColorResource.SELECT_COLOR_RED.value;
  int get currentSelectedColorId => _currentSelectedColorId;

  String _currentContent = "";
  String get currentContent => _currentContent;

  void updateCurrentId(int id) {
    _currentId = id;
  }

  void updateCurrentDateTime(DateTime dateTime) {
    _currentDateTime = dateTime;
  }

  void updateCurrentStatTime(int time) {
    _currentStartTime = time;
  }

  void updateCurrentEndTime(int time) {
    _currentEndTime = time;
  }

  void updateCurrentColorSelectedId(int id) {
    _currentSelectedColorId = id;
  }

  void updateCurrentContent(String content) {
    _currentContent = content;
  }
}
