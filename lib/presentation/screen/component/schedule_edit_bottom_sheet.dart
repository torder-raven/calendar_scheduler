import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/time_input_field.dart';
import 'package:calendar_scheduler/presentation/util/validation_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../../domain/usecase/update_schedule.dart';
import '../../const/colors.dart';
import '../../const/strings.dart';
import '../../util/toast_util.dart';
import 'color_selection_field.dart';
import 'content_input_field.dart';

DateTime currentDateTime = DateTime.now();
int currentStartTime = 0;
int currentEndTime = 0;
int currentSelectedColorId = ColorResource.selectorColors[0].value;
String currentContent = "";
int currentId = 0;

class ScheduleEditBottomSheet extends StatefulWidget {
  final Schedule prevSchedule;

  const ScheduleEditBottomSheet({
    super.key,
    required this.prevSchedule,
  });

  @override
  State<ScheduleEditBottomSheet> createState() =>
      _ScheduleEditBottomSheetState();
}

class _ScheduleEditBottomSheetState extends State<ScheduleEditBottomSheet> {
  final colors = ColorResource.selectorColors;

  @override
  void initState() {
    currentDateTime = widget.prevSchedule.date;
    currentStartTime = widget.prevSchedule.startTime;
    currentEndTime = widget.prevSchedule.endTime;
    currentSelectedColorId = widget.prevSchedule.colorCode;
    currentContent = widget.prevSchedule.content;
    currentId = widget.prevSchedule.id;
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
              selectedDate: widget.prevSchedule.date,
            ),
            ColorSelectionField(
              colors: colors,
              selectedColorId: currentSelectedColorId,
              colorIdSetter: (int id) {
                setState(() {
                  currentSelectedColorId = id;
                });
              },
            ),
            const Spacer(),
            _TimeInputRenderer(),
            const Spacer(),
            ContentInputField(
              initialContent: currentContent,
              contentSetter: (String content) {
                setState(() {
                  currentContent = content;
                });
              },
            ),
            const Spacer(),
            const _EditScheduleButton(),
          ],
        ),
      ),
    );
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
            initialTime: currentStartTime,
            selectedTimeType: Strings.LABEL_START_TIME,
            timeSetter: (int time) {
              setState(() {
                currentStartTime = time;
              });
            },
          ),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Expanded(
          child: TimeInputField(
            initialTime: currentEndTime,
            selectedTimeType: Strings.LABEL_END_TIME,
            timeSetter: (int time) {
              setState(() {
                currentEndTime = time;
              });
            },
          ),
        )
      ],
    );
  }
}

class _EditScheduleButton extends StatelessWidget {
  const _EditScheduleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            onPressEditEvent(context);
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: ColorResource.BUTTON_NORMAL_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          child: const Text(
            Strings.EDIT,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  void onPressEditEvent(context) {
    if (ValidationUtil.checkInputValidations(
      currentStartTime,
      currentEndTime,
      currentContent,
    )) {
      editSchedule();
      Navigator.of(context).pop();
    }
  }

  Future<void> editSchedule() async {
    final updateSchedule = serviceLocator<UpdateScheduleUsecase>();
    final schedule = Schedule(
      date: currentDateTime,
      startTime: currentStartTime,
      endTime: currentEndTime,
      colorCode: currentSelectedColorId,
      content: currentContent,
      id: currentId,
    );
    await updateSchedule.invoke(schedule: schedule);
  }
}
