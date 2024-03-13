import 'package:calendar_scheduler/domain/usecase/get_all_schedule.dart';
import 'package:calendar_scheduler/presentation/const/strings.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule.builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../../domain/usecase/delete_shcedule.dart';

class ScheduleListView extends StatelessWidget {
  final DateTime date;

  const ScheduleListView({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder(
          stream: GetIt.I<GetAllScheduleUsecase>().invoke(date),
          builder: (context, snapshot) {
            return buildScheduleList(snapshot, context);
          },
        ),
      ),
    );
  }
}
