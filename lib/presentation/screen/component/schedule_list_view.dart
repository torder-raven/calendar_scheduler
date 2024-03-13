import 'package:calendar_scheduler/domain/entity/schedule.dart';
import 'package:calendar_scheduler/domain/usecase/get_all_schedule.dart';
import 'package:calendar_scheduler/presentation/const/strings.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleListView extends StatelessWidget {
  final DateTime date;

  const ScheduleListView({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder(
            future: GetIt.I<GetAllScheduleUsecase>().invoke(date),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    Strings.EMPTY_SCHEDULE,
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              }

              final list = snapshot.requireData;

              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  final schedule = list[index];

                  return ScheduleCard(
                    startTime: schedule.startTime,
                    endTime: schedule.endTime,
                    content: schedule.content,
                    color: schedule.colorCode,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return DefaultComponent.defaultHeightSizedBox;
                },
                itemCount: list.length,
              );
            }),
      ),
    );
  }
}
