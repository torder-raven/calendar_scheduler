import 'package:calendar_scheduler/presentation/screen/component/time_input_field.dart';
import 'package:flutter/material.dart';

import '../../const/strings.dart';
import 'color_selection_field.dart';
import 'content_input_field.dart';


class ScheduleRegisterBottomSheet extends StatelessWidget {
  final DateTime selectedDate;

  const ScheduleRegisterBottomSheet({super.key, required this.selectedDate});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BottomSheetHeader(
                selectedDate: selectedDate,
              ),
              ColorSelectionField(colorCode: 0),
              _TimeInputRenderer(),
              ContentInputField(),
            ],
          ),
        ),
      ),
    );
  }
}

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

class _TimeInputRenderer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TimeInputField(
            selectedTimeType: Strings.LABEL_START_TIME,
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          child: TimeInputField(
            selectedTimeType: Strings.LABEL_END_TIME,
          ),
        ),
      ],
    );
  }
}
