import 'package:calendar_scheduler/domain/usecase/delete_shcedule.dart';
import 'package:calendar_scheduler/domain/usecase/temporary_delete_schedule.dart';
import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../const/strings.dart';

class TempDeleteItem extends StatelessWidget {
  final Schedule schedule;

  const TempDeleteItem({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
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
}

class DeleteItem extends StatefulWidget {
  final Schedule schedule;

  const DeleteItem({super.key, required this.schedule});

  @override
  State<DeleteItem> createState() => _DeleteItemState();
}

class _DeleteItemState extends State<DeleteItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(widget.schedule.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) =>
          showDeleteDialog(widget.schedule.id, context),
      child: GestureDetector(
        child: ScheduleCard(
          startTime: widget.schedule.startTime,
          endTime: widget.schedule.endTime,
          content: widget.schedule.content,
          color: widget.schedule.colorCode,
        ),
      ),
    );
  }
}

Future<bool?> showDeleteDialog(
  int sheduleId,
  BuildContext context,
) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(
        Strings.DELETE_CONFIRM_TITLE,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: ColorResource.BUTTON_NORMAL_COLOR),
      ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(Strings.CANCEL),
          ),
          TextButton(
            onPressed: () => {
              serviceLocator<DeleteScheduleUsecase>()
                  .invoke(scheduleId: sheduleId),
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
        title: Text(
          Strings.TEMP_DELETE_CONFIRM_TITLE,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: ColorResource.BUTTON_NORMAL_COLOR),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(Strings.CANCEL),
          ),
          TextButton(
            onPressed: () => {
              serviceLocator<TemporaryDeleteScheduleUsecase>()
                  .invoke(scheduleId: sheduleId),
            },
            child: Text(Strings.DELETE),
          ),
        ],
      );
    },
  );
}
