import 'package:calendar_scheduler/domain/usecase/delete_shcedule.dart';
import 'package:calendar_scheduler/domain/usecase/temporary_delete_schedule.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_card.dart';
import 'package:flutter/material.dart';
import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../const/strings.dart';

class TempDeleteItem extends StatefulWidget {
  final Schedule schedule;

  const TempDeleteItem({super.key, required this.schedule});

  @override
  State<TempDeleteItem> createState() => _TempDeleteItemState();
}

class _TempDeleteItemState extends State<TempDeleteItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(widget.schedule.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) => showTempDeleteDialog(widget.schedule.id, context),
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
      confirmDismiss: (direction) => showDeleteDialog(widget.schedule.id, context),
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
            },
            child: Text(Strings.DELETE),
          ),
        ],
      );
    },
  );
}