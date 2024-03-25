import 'package:calendar_scheduler/di/locator.dart';
import 'package:calendar_scheduler/domain/usecase/get_all_schedule.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_bottom_sheet/edit_schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entity/schedule.dart';
import '../../const/strings.dart';
import '../provider/schedule_provider.dart';
import 'default_component.dart';

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
          stream: serviceLocator<GetAllScheduleUsecase>().invoke(date),
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
              itemCount: snapshot.data?.length ?? 0,
              separatorBuilder: (context, index) {
                return DefaultComponent.defaultSizedBoxWithHeight;
              },
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  showEditBottomSheet(context, list[index]);
                },
                child: TempDeleteItem(schedule: list[index]),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {}
}

void showEditBottomSheet(BuildContext context, Schedule schedule) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (_) {
      return ChangeNotifierProvider(
        create: (BuildContext context) => ScheduleProvider(),
        child: EditScheduleBottomSheet(
          prevSchedule: schedule,
        ),
      );
    },
  );
}
