import 'dart:js';

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
  final provider = Provider.of<ScheduleProvider>(context as BuildContext);

  @override
  void initState() {
    super.initState();
    provider.updateCurrentColorSelectedId(colors.first.value);
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
              selectedColorId: provider.currentSelectedColorId,
              colorIdSetter: (int id) {
                setState(() {
                  provider.updateCurrentColorSelectedId(id);
                });
              },
            ),
            const Spacer(),
            _TimeInputRenderer(),
            const Spacer(),
            ContentInputField(
              initialContent: provider.currentContent,
              contentSetter: (String content) {
                setState(() {
                  provider.updateCurrentContent(content);
                });
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
    resetPrevData();
    super.dispose();
  }

  void resetPrevData() {
/*    currentStartTime = 0;
    currentEndTime = 0;
    currentSelectedColorId = ColorResource.selectorColors[0].value;
    currentContent = "";*/
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
            initialTime: Provider.of<ScheduleProvider>(context).currentStartTime,
            selectedTimeType: Strings.LABEL_START_TIME,
            timeSetter: (int time) {
              setState(() {
                Provider.of<ScheduleProvider>(context).updateCurrentStatTime(time);
              });
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
              setState(() {
                Provider.of<ScheduleProvider>(context).updateCurrentEndTime(time);
              });
            },
          ),
        )
      ],
    );
  }
}

class _SaveScheduleButton extends StatelessWidget {
  final currentDateTime;

  const _SaveScheduleButton({required this.currentDateTime, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            onPressSaveEvent(context);
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: ColorResource.BUTTON_NORMAL_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          child: const Text(
            Strings.SAVE,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  void onPressSaveEvent(context) {
    if (ValidationUtil.checkInputValidations(
      Provider.of<ScheduleProvider>(context).currentStartTime,
      Provider.of<ScheduleProvider>(context).currentEndTime,
      Provider.of<ScheduleProvider>(context).currentContent,
    )) {
      saveSchedule();
      Navigator.of(context).pop();
    }
  }

  Future<void> saveSchedule() async {
    final registerSchedule = serviceLocator<RegisterScheduleUsecase>();
    final schedule = Schedule(
      date: currentDateTime,
      startTime: Provider.of<ScheduleProvider>(context as BuildContext).currentStartTime,
      endTime: Provider.of<ScheduleProvider>(context as BuildContext).currentEndTime,
      colorCode: Provider.of<ScheduleProvider>(context as BuildContext).currentSelectedColorId,
      content: Provider.of<ScheduleProvider>(context as BuildContext).currentContent,
    );
    await registerSchedule.invoke(schedule: schedule);
  }
}
