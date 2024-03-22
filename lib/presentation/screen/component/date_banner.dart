import 'package:calendar_scheduler/di/locator.dart';
import 'package:calendar_scheduler/domain/usecase/get_all_schedule.dart';
import 'package:calendar_scheduler/presentation/const/strings.dart';
import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/calendar/provider/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateBanner extends StatelessWidget {
  const DateBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    return Container(
      color: theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CalendarProvider>(
          builder: (context, value, child) {
            final date = context.read<CalendarProvider>().selectedDay;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date.toFormattedString(Strings.DATE_FORMAT),
                  style: textStyle,
                ),
                countText(
                  date: date,
                  style: textStyle,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget countText({
    required DateTime date,
    required TextStyle style,
  }) {
    return StreamBuilder(
        stream: serviceLocator<GetAllScheduleUsecase>().invoke(date),
        builder: (context, snapshot) {
          int count = 0;
          if (snapshot.hasData) {
            count = snapshot.requireData.length;
          }

          return Text(
            count.addUnit(Strings.DATE_COUNT_UNIT),
            style: style,
          );
        });
  }
}
