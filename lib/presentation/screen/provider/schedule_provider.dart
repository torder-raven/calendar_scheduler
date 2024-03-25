import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../../domain/usecase/register_schedule.dart';
import '../../../domain/usecase/update_schedule.dart';
import '../../util/validation_util.dart';

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

  bool isFieldInputValid() {
    return ValidationUtil.checkInputValidations(
      currentStartTime,
      currentEndTime,
      currentContent,
    );
  }

  Future<void> saveSchedule() async {
    final registerSchedule = serviceLocator<RegisterScheduleUsecase>();
    final schedule = Schedule(
      date: currentDateTime,
      startTime: currentStartTime,
      endTime: currentEndTime,
      colorCode: currentSelectedColorId,
      content: currentContent,
    );
    await registerSchedule.invoke(schedule: schedule);
  }

  Future<void> editSchedule() async {
    final updateSchedule = serviceLocator<UpdateScheduleUsecase>();
    final schedule = Schedule(
      date: currentDateTime,
      startTime: currentStartTime,
      endTime: currentEndTime,
      colorCode: currentSelectedColorId,
      content: currentContent,
      id: currentId,
    );
    await updateSchedule.invoke(schedule: schedule);
  }

  Future<void> repeatSchedule(selectedDateTime, schedule) async {
    final registerSchedule = serviceLocator<RegisterScheduleUsecase>();
    final prevSchedule = Schedule(
      date: selectedDateTime,
      startTime: schedule.startTime,
      endTime: schedule.endTime,
      colorCode: schedule.colorCode,
      content: schedule.content,
    );
    await registerSchedule.invoke(schedule: prevSchedule);
  }

  Future<void> changeScheduleDate(selectedDateTime, schedule) async {
    final updateSchedule = serviceLocator<UpdateScheduleUsecase>();
    final prevSchedule = Schedule(
      date: selectedDateTime,
      startTime: schedule.startTime,
      endTime: schedule.endTime,
      colorCode: schedule.colorCode,
      content: schedule.content,
      id: schedule.id,
    );
    await updateSchedule.invoke(schedule: prevSchedule);
  }

}
