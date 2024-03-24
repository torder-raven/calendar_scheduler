import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../../domain/usecase/register_schedule.dart';
import '../../../domain/usecase/update_schedule.dart';
import '../../const/colors.dart';
import '../../const/strings.dart';
import '../../const/styles.dart';
import 'default_component.dart';

class DateControlDialog {
   void showDateControlDialog(BuildContext context, Schedule schedule) {
    showDialog(
      context: context,
      builder: (context) => _DateControlDialogWidget(schedule: schedule),
    );
  }
}

class _DateControlDialogWidget extends StatelessWidget {
  final Schedule schedule;

  const _DateControlDialogWidget({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: DefaultComponent.defaultPaddingSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                showScheduleDatePicker(context, schedule, true);
              },
              style: Styles.dialogButtonStyle,
              child: const Text(
                Strings.REPEAT_SCHEDULE_ON_OTHER_DATE,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showScheduleDatePicker(context, schedule, false);
              },
              style: Styles.dialogButtonStyle,
              child: const Text(
                Strings.CHANGE_SCHEDULE_DATE,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
              ),
              child: const Text(
                Strings.CLOSE,
                style: TextStyle(
                  color: ColorResource.BUTTON_NORMAL_COLOR,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showScheduleDatePicker(BuildContext context, Schedule schedule, bool repeatFlag) {
    showDialog(
      context: context,
      builder: (context) => _ScheduleDatePickerWidget(schedule: schedule, repeatFlag: repeatFlag),
    );
  }
}

class _ScheduleDatePickerWidget extends StatelessWidget {
  final Schedule schedule;
  final bool repeatFlag;

  const _ScheduleDatePickerWidget({
    Key? key,
    required this.schedule,
    required this.repeatFlag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime = schedule.date;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                height: 200.0,
                child: CupertinoDatePicker(
                  initialDateTime: schedule.date,
                  dateOrder: DatePickerDateOrder.ymd,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime value) {
                    selectedDateTime = value.toUtcDate();
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: const Text(
                        Strings.CANCEL_TEXT,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (repeatFlag)
                          await repeatScheduleOnOtherDate(schedule, selectedDateTime);
                        else
                          await changeScheduleDate(schedule, selectedDateTime);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorResource.BUTTON_NORMAL_COLOR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: const Text(
                        Strings.CONFIRM,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Future<void> repeatScheduleOnOtherDate(
    Schedule schedule, DateTime dateTime) async {
  final registerSchedule = serviceLocator<RegisterScheduleUsecase>();
  final prevSchedule = Schedule(
    date: dateTime,
    startTime: schedule.startTime,
    endTime: schedule.endTime,
    colorCode: schedule.colorCode,
    content: schedule.content,
  );
  await registerSchedule.invoke(schedule: prevSchedule);
}

Future<void> changeScheduleDate(Schedule schedule, DateTime dateTime) async {
  final updateSchedule = serviceLocator<UpdateScheduleUsecase>();
  final prevSchedule = Schedule(
    date: dateTime,
    startTime: schedule.startTime,
    endTime: schedule.endTime,
    colorCode: schedule.colorCode,
    content: schedule.content,
    id: schedule.id,
  );
  await updateSchedule.invoke(schedule: prevSchedule);
}

