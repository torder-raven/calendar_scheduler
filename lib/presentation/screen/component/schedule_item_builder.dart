import 'dart:io';

import 'package:calendar_scheduler/domain/usecase/delete_shcedule.dart';
import 'package:calendar_scheduler/domain/usecase/temporary_delete_schedule.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../const/strings.dart';
import 'confirm_dialog.dart';

class TempDeleteItem extends StatelessWidget {
  final Schedule schedule;

  const TempDeleteItem({super.key, required this.schedule});

  void tempDeleteItem() {
    serviceLocator<TemporaryDeleteScheduleUsecase>()
        .invoke(scheduleId: schedule.id);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(schedule.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) => Platform.isAndroid
          ? androidDialog(
          onConfirm: tempDeleteItem,
          title: Strings.TEMP_DELETE_CONFIRM_TITLE,
          context: context)
          : iosDialog(
          onConfirm: tempDeleteItem,
          title: Strings.TEMP_DELETE_CONFIRM_TITLE,
          context: context),
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

class DeleteItem extends StatelessWidget {
  final Schedule schedule;

  const DeleteItem({super.key, required this.schedule});

  void deleteItem() {
    serviceLocator<DeleteScheduleUsecase>().invoke(scheduleId: schedule.id);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(schedule.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) => Platform.isAndroid
          ? androidDialog(
        onConfirm: deleteItem,
        title: Strings.DELETE_CONFIRM_TITLE,
        context: context,
      )
          : iosDialog(
        onConfirm: deleteItem,
        title: Strings.DELETE_CONFIRM_TITLE,
        context: context,
      ),
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

class NormalItem extends StatelessWidget {
  final Schedule schedule;

  const NormalItem({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return ScheduleCard(
      startTime: schedule.startTime,
      endTime: schedule.endTime,
      content: schedule.content,
      color: schedule.colorCode,
    );
  }
}

