import 'package:calendar_scheduler/presentation/screen/component/schedule_card.dart';
import 'package:flutter/material.dart';
import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../../domain/usecase/delete_shcedule.dart';
import '../../const/strings.dart';
import 'default_component.dart';

Widget buildScheduleList(
    AsyncSnapshot<List> snapshot, BuildContext context) {
  if (!snapshot.hasData) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (snapshot.hasData && snapshot.data!.isEmpty) {
    return Center(
      child: Text(
        Strings.EMPTY_SCHEDULE,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
  final list = snapshot.requireData;

  return ListView.separated(
    itemCount: snapshot.data?.length ?? 0,
    separatorBuilder: (context, index) {
      return DefaultComponent.defaultSizedBoxWithHeight;
    },
    itemBuilder: (context, index) =>
        buildScheduleListItem(context, list[index]),
  );
}

Future<bool?> showDismissDialog(
    BuildContext context,
    DismissDirection direction,
    VoidCallback onDelete,
    VoidCallback onDeleteCancel,
    ) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text(Strings.DELETE_CONFIRM_TEXT),
        content: Text(Strings.TEMP_DELETE_WARNING),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => onDelete,
            child: const Text(Strings.CANCEL),
          ),
          ElevatedButton(
            onPressed: () => onDeleteCancel,
            child: Text(Strings.DELETE),
          ),
        ],
      );
    },
  );
}

Widget buildScheduleListItem(BuildContext context, Schedule schedule) {
  deleteSchedule() {
    serviceLocator<DeleteScheduleUsecase>().invoke(scheduleId: schedule.id);
    Navigator.of(context).pop(true);
  }

  cancelToDeleteSchedule() {
    Navigator.of(context).pop(false);
  }

  return Dismissible(
    key: ObjectKey(schedule.id),
    direction: DismissDirection.horizontal,
    confirmDismiss: (direction) => showDismissDialog(
        context, direction, deleteSchedule, cancelToDeleteSchedule),
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