import 'package:calendar_scheduler/domain/usecase/delete_shcedule.dart';
import 'package:calendar_scheduler/domain/usecase/temporary_delete_schedule.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_card.dart';
import 'package:flutter/material.dart';
import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../const/strings.dart';

Widget buildTempDeleteScheduleListItem(BuildContext context, Schedule schedule) {
  return Dismissible(
    key: ObjectKey(schedule.id),
    direction: DismissDirection.horizontal,
    confirmDismiss: (direction) => showDeleteDialog(schedule.id, context),
    child: GestureDetector(
      child: ScheduleCard(
        startTime: schedule.startTime,
        endTime: schedule.endTime,
        content: schedule.content,
        color: schedule.colorCode,
      ),
    ),
  );
}

Widget buildScheduleListItem(BuildContext context, Schedule schedule) {
  return Dismissible(
    key: ObjectKey(schedule.id),
    direction: DismissDirection.horizontal,
    confirmDismiss: (direction) => showTempDeleteDialog(schedule.id, context),
    child: GestureDetector(
      child: ScheduleCard(
        startTime: schedule.startTime,
        endTime: schedule.endTime,
        content: schedule.content,
        color: schedule.colorCode,
      ),
    ),
  );
}

Future<bool?> showDeleteDialog(
    int sheduleId,
    BuildContext context,
    ) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text(Strings.DELETE_CONFIRM_TEXT),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(Strings.CANCEL),
          ),
          ElevatedButton(
            onPressed: () => {
              serviceLocator<DeleteScheduleUsecase>().invoke(scheduleId: sheduleId),
              Navigator.of(context).pop(true)
            },
            child: Text(Strings.DELETE),
          ),
        ],
      );
    },
  );
}

Future<bool?> showTempDeleteDialog(
    int sheduleId,
    BuildContext context,
    ) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text(Strings.TEMP_DELETE_CONFIRM_TEXT),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(Strings.CANCEL),
          ),
          ElevatedButton(
            onPressed: () => {
              serviceLocator<TemporaryDeleteScheduleUsecase>().invoke(scheduleId: sheduleId),
              Navigator.of(context).pop(true),
            },
            child: Text(Strings.DELETE),
          ),
        ],
      );
    },
  );
}