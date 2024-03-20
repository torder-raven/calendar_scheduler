import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:flutter/cupertino.dart';

class ScheduleProvider with ChangeNotifier {
  int _currentStartTime = 0;
  int get currentStartTime => _currentStartTime;

  int _currentEndTime = 0;
  int get currentEndTime => _currentEndTime;

  int _currentSelectedColorId = ColorResource.SELECT_COLOR_RED.value;
  int get currentSelectedColorId => _currentSelectedColorId;

  String _currentContent = "";
  String get currentContent => _currentContent;

  void updateCurrentStatTime(int time) {
    _currentStartTime = time;
  }

  void updateCurrentEndTime(int time) {
    _currentEndTime = time;
  }

  void updateCurrentColorSelectedId(int id) {
    _currentSelectedColorId = id;
    notifyListeners();
  }

  void updateCurrentContent(String content) {
    _currentContent = content;
  }

}
