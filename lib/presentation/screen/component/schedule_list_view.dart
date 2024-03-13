import 'package:calendar_scheduler/domain/usecase/get_all_schedule.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../const/strings.dart';
import 'default_component.dart';

class ScheduleListView extends StatelessWidget {
  final DateTime date;

  const ScheduleListView({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder(
          stream: GetIt.I<GetAllScheduleUsecase>().invoke(date),
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
              itemBuilder: (context, index) => TempDeleteItem(schedule: list[index]),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {}
}

