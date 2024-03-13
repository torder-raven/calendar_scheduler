import 'package:calendar_scheduler/domain/entity/schedule.dart';
import 'package:calendar_scheduler/domain/usecase/delete_shcedule.dart';
import 'package:calendar_scheduler/domain/usecase/get_temporary_delete_schedule.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:flutter/material.dart';
import '../../../di/locator.dart';
import '../../const/strings.dart';
import '../component/schedule_card.dart';

class TempDeleteScreen extends StatefulWidget {
  const TempDeleteScreen({Key? key}) : super(key: key);

  @override
  State<TempDeleteScreen> createState() => _TempDeleteScreenState();
}

class _TempDeleteScreenState extends State<TempDeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultComponent.defaultSizedBoxWithHeight,
            _Title(),
            DefaultComponent.defaultSizedBoxWithHeight,
            _WarningText(),
            DefaultComponent.defaultSizedBoxWithHeight,
            _ScheduleList(),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.TEMP_DELETE_TITLE,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class _WarningText extends StatelessWidget {
  const _WarningText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultComponent.defaultSizedBoxWithHeight,
        Text(
          Strings.TEMP_DELETE_WARNING,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: DefaultComponent.defaultPaddingSize,
        child: FutureBuilder<List<Schedule>>(
          future: serviceLocator<GetTemporaryDeleteScheduleUsecase>().invoke(),
          builder: (context, AsyncSnapshot<List> snapData) =>
              _buildScheduleList(snapData, context),
        ),
      ),
    );
  }

  Widget _buildScheduleList(
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
          _buildScheduleListItem(context, list[index]),
    );
  }

  Widget _buildScheduleListItem(BuildContext context, Schedule schedule) {
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
      confirmDismiss: (direction) => _showDismissDialog(
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

  Future<bool?> _showDismissDialog(
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
}
