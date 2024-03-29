import 'package:calendar_scheduler/domain/usecase/register_schedule.dart';
import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/time_input_field.dart';
import 'package:calendar_scheduler/presentation/util/toast_util.dart';
import 'package:flutter/material.dart';

import '../../../di/locator.dart';
import '../../../domain/entity/schedule.dart';
import '../../const/strings.dart';
import 'color_selection_field.dart';
import 'content_input_field.dart';

int currentStartTime = 0;
int currentEndTime = 0;
int currentSelectedColorId = 0;
String currentContent = "";

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
    currentSelectedColorId = colors.first.value;
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
                selectedDate: widget.selectedDate,
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
              _SaveScheduleButton(
                currentDateTime: widget.selectedDate,
              ),
            ],
          ),
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
    currentStartTime = 0;
    currentEndTime = 0;
    currentSelectedColorId = ColorResource.selectorColors[0].value;
    currentContent = "";
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
    if (checkInputValidations()) {
      saveSchedule();
      Navigator.of(context).pop();
    }
  }

  bool checkInputValidations() {
    bool isTimeInputValid() => currentStartTime < currentEndTime;
    bool isContentInputValid() => currentContent.isNotEmpty;

    if (!isTimeInputValid()) {
      ToastUtil().showDefaultToast(Strings.INPUT_ERROR_TIME);
      return false;
    }

    if (!isContentInputValid()) {
      ToastUtil().showDefaultToast(Strings.INPUT_ERROR_CONTENT);
      return false;
    }

    return true;
  }

  Future<void> saveSchedule() async {
    final registerSchedule = serviceLocator<RegisterScheduleUsecase>();
    final schedule = Schedule(
      date: currentDateTime,
      startTime: currentStartTime,
      endTime: currentEndTime,
      colorCode: currentSelectedColorId,
      content: currentContent,
    );
    await registerSchedule.invoke(schedule: schedule);
  }
}
