import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/time_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../../domain/usecase/update_schedule.dart';
import '../../const/colors.dart';
import '../../const/strings.dart';
import 'color_selection_field.dart';
import 'content_input_field.dart';

DateTime currentDateTime = DateTime.now();
int currentStartTime = 0;
int currentEndTime = 0;
int currentSelectedColorId = ColorResource.selectorColors[0].value;
String currentContent = "";
int currentId = 0;

class ScheduleEditBottomSheet extends StatefulWidget {
  final DateTime prevDateTime;
  final int prevStartTime;
  final int prevEndTime;
  final int prevSelectedColorId;
  final String prevContent;
  final int prevId;

  const ScheduleEditBottomSheet({
    super.key,
    required this.prevDateTime,
    required this.prevStartTime,
    required this.prevEndTime,
    required this.prevSelectedColorId,
    required this.prevContent,
    required this.prevId,
  });

  @override
  State<ScheduleEditBottomSheet> createState() =>
      _ScheduleEditBottomSheetState();
}

class _ScheduleEditBottomSheetState extends State<ScheduleEditBottomSheet> {
  @override
  void initState() {
    currentDateTime = widget.prevDateTime;
    currentStartTime = widget.prevStartTime;
    currentEndTime = widget.prevEndTime;
    currentSelectedColorId = widget.prevSelectedColorId;
    currentContent = widget.prevContent;
    currentId = widget.prevId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: ((MediaQuery.of(context).size.height / 2) + bottomInset),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BottomSheetHeader(
                selectedDate: widget.prevDateTime,
              ),
              ColorSelectionField(
                initialSelectedColorId: currentSelectedColorId,
                colorIdSetter: (int id) {
                  setState(() {
                    currentSelectedColorId = id;
                  });
                },
              ),
              Spacer(),
              _TimeInputRenderer(),
              Spacer(),
              ContentInputField(
                initialContent: currentContent,
                contentSetter: (String content) {
                  setState(() {
                    currentContent = content;
                  });
                },
              ),
              Spacer(),
              Container(child: _SaveScheduleButton()),
            ],
          ),
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

class _SaveScheduleButton extends StatelessWidget {
  const _SaveScheduleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            editSchedule(context);
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: ColorResource.BUTTON_EDIT_COLOR,
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

  Future<void> editSchedule(BuildContext context) async {
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
    Navigator.of(context).pop();
  }
}
