import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:calendar_scheduler/presentation/screen/component/time_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  int selectedColorId = ColorResource.selectorColors[0].value;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2 + bottomInset,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BottomSheetHeader(
                selectedDate: widget.selectedDate,
              ),
              ColorSelectionField(
                selectedColorId: selectedColorId,
                colorIdSetter: (int id) {
                  setState(() {
                    selectedColorId = id;
                  });
                },
              ),
              Spacer(),
              _TimeInputRenderer(),
              Spacer(),
              ContentInputField(),
              Spacer(),
              _SaveScheduleButton(),
            ],
          ),
        ),
      ),
    );
  }
}

typedef ColorIdSetter = void Function(int id);
typedef TimeSetter = void Function(int time);

class _BottomSheetHeader extends StatelessWidget {
  final DateTime selectedDate;

  const _BottomSheetHeader({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    String title =
        "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일";
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      ),
      IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.close),
      ),
    ]);
  }
}

class _TimeInputRenderer extends StatefulWidget {
  @override
  State<_TimeInputRenderer> createState() => _TimeInputRendererState();
}

class _TimeInputRendererState extends State<_TimeInputRenderer> {
  int selectedTime = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TimeInputField(
            selectedTimeType: Strings.LABEL_START_TIME,
            timeSetter: (int time) {
              setState(() {
                selectedTime = time;
              });
            },
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          child: TimeInputField(
            selectedTimeType: Strings.LABEL_END_TIME,
            timeSetter: (int time) {
              setState(() {
                selectedTime = time;
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
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: ColorResource.BUTTON_NORMAL_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          child: Text(
            Strings.TEXT_SAVE,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
