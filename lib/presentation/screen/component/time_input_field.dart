import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_register_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../const/styles.dart';

class TimeInputField extends StatefulWidget {
  final String selectedTimeType;
  final TimeSetter timeSetter;
  TimeInputField(
      {super.key, required this.selectedTimeType, required this.timeSetter});

  @override
  State<TimeInputField> createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  int selectedTime = 0;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.selectedTimeType,
          style: Styles.inputLabelTextStyle,
        ),
        const SizedBox(
          height: 6.0,
        ),
        GestureDetector(
          onTap: () {
            showTimePickerDialog();
          },
          child: TextField(
            controller: _textEditingController,
            enabled: false,
            cursorColor: Colors.grey,
            style: Styles.inputTextStyle,
            decoration: InputDecoration(
              isDense: true,
              border: Styles.inputTextOutlineInputBorder,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              filled: false,
              fillColor: Colors.white,
              hintText: 0.intTimeToTimeString(),
              hintStyle: Styles.inputTextStyle.copyWith(
                color: ColorResource.INPUT_TEXT_FIELD_HINT_COLOR,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController.removeListener;
    super.dispose();
  }

  void showTimePickerDialog() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  int totalTime = (date.hour * 60) + date.minute;
                  selectedTime = totalTime;
                  widget.timeSetter(totalTime);
                  _textEditingController.text = totalTime.intTimeToTimeString();
                });
              },
            ),
          ),
        );
      },
    );
  }
}
