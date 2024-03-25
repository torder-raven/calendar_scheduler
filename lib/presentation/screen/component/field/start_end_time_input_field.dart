import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../const/colors.dart';
import '../../../const/strings.dart';
import '../../../const/styles.dart';
import '../../provider/schedule_provider.dart';

class StartEndTimeInputField extends StatelessWidget {
  const StartEndTimeInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StartEndTimeInputField(
            initialTime: context.watch<ScheduleProvider>().currentStartTime,
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
          child: _StartEndTimeInputField(
            initialTime: context.watch<ScheduleProvider>().currentEndTime,
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

class _StartEndTimeInputField extends StatefulWidget {
  final int initialTime;
  final String selectedTimeType;
  final TimeSetter timeSetter;
  const _StartEndTimeInputField({
    super.key,
    required this.selectedTimeType,
    required this.timeSetter,
    required this.initialTime,
  });

  @override
  State<_StartEndTimeInputField> createState() => _StartEndTimeInputFieldState();
}

class _StartEndTimeInputFieldState extends State<_StartEndTimeInputField> {
  int selectedTime = 0;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.initialTime != 0) {
      selectedTime = widget.initialTime;
      _textEditingController.text = selectedTime.intTimeToTimeString();
    }
    super.initState();
  }

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
    _textEditingController.dispose();
    super.dispose();
  }

  void showTimePickerDialog() {
    DateTime currentSelectedDateTime = selectedTime.intTimeToDateTime();
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: Styles.dialogTopRadiusBoxStyle,
                    height: 200.0,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (DateTime date) {
                        currentSelectedDateTime = date;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: Styles.dialogBottomRadiusBoxStyle,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          child: const Text(
                            Strings.CANCEL_TEXT,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () => {
                            onSelectTimeEvent(currentSelectedDateTime),
                            Navigator.of(context).pop()
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ColorResource.BUTTON_NORMAL_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          child: const Text(
                            Strings.SELECT_TEXT,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onSelectTimeEvent(DateTime date) {
    setState(() {
      selectedTime = (date.hour * 60) + date.minute;
      if (selectedTime == 0) {
        selectedTime = (DateTime.now().hour * 60) + (DateTime.now().minute);
      }
      widget.timeSetter(selectedTime);
      _textEditingController.text = selectedTime.intTimeToTimeString();
    });
  }
}

typedef TimeSetter = void Function(int time);
