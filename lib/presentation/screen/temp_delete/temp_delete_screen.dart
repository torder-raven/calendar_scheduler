import 'package:calendar_scheduler/domain/entity/schedule.dart';
import 'package:calendar_scheduler/domain/usecase/get_temporary_delete_schedule.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:flutter/material.dart';
import '../../../di/locator.dart';
import '../../const/strings.dart';
import '../component/schedule.builder.dart';

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
              buildScheduleList(snapData, context),
        ),
      ),
    );
  }
}
