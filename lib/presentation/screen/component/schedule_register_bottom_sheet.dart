import 'package:calendar_scheduler/domain/usecase/register_schedule.dart';
import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/provider/schedule_provider.dart';
import 'package:calendar_scheduler/presentation/screen/component/time_input_field.dart';
import 'package:calendar_scheduler/presentation/util/validation_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../const/strings.dart';
import '../../const/styles.dart';
import 'color_selection_field.dart';
import 'content_input_field.dart';

class ScheduleRegisterBottomSheet extends StatefulWidget {
  final DateTime selectedDate;

  const ScheduleRegisterBottomSheet({super.key, required this.selectedDate});

  @override
  State<ScheduleRegisterBottomSheet> createState() =>
      _ScheduleRegisterBottomSheetState();
}

class _ScheduleRegisterBottomSheetState
    extends State<ScheduleRegisterBottomSheet> {
  final colors = ColorResource.selectorColors;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.only(bottom: bottomInset),
        width: MediaQuery.of(context).size.width,
        height: ((MediaQuery.of(context).size.height / 2) + bottomInset),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BottomSheetHeader(
              selectedDate: widget.selectedDate,
            ),
            ColorSelectionField(
              colors: colors,
              selectedColorId:
                  Provider.of<ScheduleProvider>(context).currentSelectedColorId,
              colorIdSetter: (int id) {
                context
                    .read<ScheduleProvider>()
                    .updateCurrentColorSelectedId(id);
              },
            ),
            const Spacer(),
            _TimeInputRenderer(),
            const Spacer(),
            ContentInputField(
              initialContent:
                  Provider.of<ScheduleProvider>(context).currentContent,
              contentSetter: (String content) {
                context.read<ScheduleProvider>().updateCurrentContent(content);
              },
            ),
            const Spacer(),
            _SaveScheduleButton(
              currentDateTime: widget.selectedDate,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

typedef ContentSetter = void Function(String content);
typedef ColorIdSetter = void Function(int id);
typedef TimeSetter = void Function(int time);

class _BottomSheetHeader extends StatelessWidget {
  final DateTime selectedDate;

  const _BottomSheetHeader({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    String title = selectedDate.toFormattedString(Strings.DATE_FORMAT);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.close),
      ),
    ]);
  }
}

class _TimeInputRenderer extends StatefulWidget {
  @override
  State<_TimeInputRenderer> createState() => _TimeInputRendererState();
}

class _TimeInputRendererState extends State<_TimeInputRenderer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TimeInputField(
            initialTime:
                Provider.of<ScheduleProvider>(context).currentStartTime,
            selectedTimeType: Strings.LABEL_START_TIME,
            timeSetter: (int time) {
              context.read<ScheduleProvider>().updateCurrentStatTime(time);
            },
          ),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Expanded(
          child: TimeInputField(
            initialTime: Provider.of<ScheduleProvider>(context).currentEndTime,
            selectedTimeType: Strings.LABEL_END_TIME,
            timeSetter: (int time) {
              context.read<ScheduleProvider>().updateCurrentEndTime(time);
            },
          ),
        )
      ],
    );
  }
}

class _SaveScheduleButton extends StatelessWidget {
  final DateTime currentDateTime;

  const _SaveScheduleButton({required this.currentDateTime});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.read<ScheduleProvider>();
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            onPressSaveEvent(scheduleProvider, context);
          },
          style: Styles.normalButtonStyle,
          child: const Text(
            Strings.SAVE,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  void onPressSaveEvent(scheduleProvider, context) {
    if (ValidationUtil.checkInputValidations(
      scheduleProvider.currentStartTime,
      scheduleProvider.currentEndTime,
      scheduleProvider.currentContent,
    )) {
      saveSchedule(scheduleProvider, context);
      Navigator.of(context).pop();
    }
  }

  Future<void> saveSchedule(scheduleProvider, context) async {
    final registerSchedule = serviceLocator<RegisterScheduleUsecase>();
    final schedule = Schedule(
      date: currentDateTime,
      startTime: scheduleProvider.currentStartTime,
      endTime: scheduleProvider.currentEndTime,
      colorCode: scheduleProvider.currentSelectedColorId,
      content: scheduleProvider.currentContent,
    );
    await registerSchedule.invoke(schedule: schedule);
  }
}
