import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_register_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';

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
  TextEditingController _textEditingController = TextEditingController();

  TextStyle textStyle = const TextStyle(
      color: ColorResource.INPUT_TEXT_FIELD_FILL_COLOR,
      fontWeight: FontWeight.w400,
      fontSize: 13.0);

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: ColorResource.INPUT_TEXT_FIELD_BORDER_COLOR,
    ),
    borderRadius: BorderRadius.circular(8.0),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.selectedTimeType,
          style: TextStyle(
            color: ColorResource.INPUT_TEXT_LABEL_COLOR,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        GestureDetector(
          onTap: () {
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
                          _textEditingController.text =
                              totalTime.intTimeToTimeString();
                        });
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: TextField(
            controller: _textEditingController,
            enabled: false,
            cursorColor: Colors.grey,
            style: textStyle,
            decoration: InputDecoration(
              isDense: true,
              border: outlineInputBorder,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              filled: false,
              fillColor: Colors.white,
              hintText: "00:00",
              hintStyle: textStyle.copyWith(
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
  }
}
