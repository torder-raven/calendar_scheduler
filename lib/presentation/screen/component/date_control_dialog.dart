import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../domain/entity/schedule.dart';
import '../../const/colors.dart';
import '../../const/strings.dart';
import '../../const/styles.dart';
import '../provider/schedule_provider.dart';
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

  const _DateControlDialogWidget({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: DefaultComponent.defaultPaddingSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            renderDateControlActionButton(
              context,
              Strings.REPEAT_SCHEDULE_ON_OTHER_DATE,
            ),
            renderDateControlActionButton(
              context,
              Strings.CHANGE_SCHEDULE_DATE,
            ),
            renderCloseActionButton(context)
          ],
        ),
      ),
    );
  }

  Widget renderDateControlActionButton(
      BuildContext context, String controlText) {
    return ElevatedButton(
      onPressed: () {
        showScheduleDatePicker(context, controlText, schedule);
      },
      style: Styles.dialogButtonStyle,
      child: Text(
        controlText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget renderCloseActionButton(BuildContext context) {
    return TextButton(
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
    );
  }

  void showScheduleDatePicker(
      BuildContext context, controlText, Schedule schedule) {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider(
        create: (BuildContext context) => ScheduleProvider(),
        child: _ScheduleDatePickerWidget(
            schedule: schedule, controlText: controlText),
      ),
    );
  }
}

class _ScheduleDatePickerWidget extends StatelessWidget {
  final Schedule schedule;
  final String controlText;

  const _ScheduleDatePickerWidget({
    required this.schedule,
    required this.controlText,
  });

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
                    child: renderCancelButton(context),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: renderConfirmButton(
                        context, selectedDateTime, schedule),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderCancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        removeStack(context);
      },
      style: Styles.cancelButtonStyle,
      child: const Text(
        Strings.CANCEL_TEXT,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget renderConfirmButton(context, selectedDateTime, schedule) {
    return ElevatedButton(
      onPressed: () async {
        updateSchedule(context, controlText, selectedDateTime, schedule);
        removeStack(context);
      },
      style: Styles.confirmButtonStyle,
      child: const Text(
        Strings.CONFIRM,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  void updateSchedule(context, controlText, selectedDateTime, schedule) {
    if (controlText == Strings.REPEAT_SCHEDULE_ON_OTHER_DATE) {
      Provider.of<ScheduleProvider>(context, listen: false)
          .repeatSchedule(selectedDateTime, schedule);
    } else {
      Provider.of<ScheduleProvider>(context, listen: false)
          .changeScheduleDate(selectedDateTime, schedule);
    }
  }

  void removeStack(context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
