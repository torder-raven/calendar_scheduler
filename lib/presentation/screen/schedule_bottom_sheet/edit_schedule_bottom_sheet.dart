import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/field/time_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entity/schedule.dart';
import '../../const/colors.dart';
import '../../const/strings.dart';
import '../../const/styles.dart';
import '../provider/schedule_provider.dart';
import '../component/field/color_selection_field.dart';
import '../component/field/content_input_field.dart';

class EditScheduleBottomSheet extends StatefulWidget {
  final Schedule prevSchedule;

  const EditScheduleBottomSheet({
    super.key,
    required this.prevSchedule,
  });

  @override
  State<EditScheduleBottomSheet> createState() =>
      _EditScheduleBottomSheetState();
}

class _EditScheduleBottomSheetState extends State<EditScheduleBottomSheet> {
  final colors = ColorResource.selectorColors;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    initPrevCurrentScheduleData();
    super.didChangeDependencies();
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
            const _BottomSheetHeader(),
            ColorSelectionField(
              colors: colors,
              selectedColorId:
                  context.watch<ScheduleProvider>().currentSelectedColorId,
              colorIdSetter: (int id) {
                setState(() {
                  context
                      .read<ScheduleProvider>()
                      .updateCurrentColorSelectedId(id);
                });
              },
            ),
            const Spacer(),
            _TimeInputRenderer(),
            const Spacer(),
            ContentInputField(
              initialContent: context.watch<ScheduleProvider>().currentContent,
              contentSetter: (String content) {
                context.read<ScheduleProvider>().updateCurrentContent(content);
              },
            ),
            const Spacer(),
            const _EditScheduleButton(),
          ],
        ),
      ),
    );
  }

  void initPrevCurrentScheduleData() {
    context.watch<ScheduleProvider>().updateCurrentId(widget.prevSchedule.id);
    context
        .watch<ScheduleProvider>()
        .updateCurrentDateTime(widget.prevSchedule.date);
    context
        .watch<ScheduleProvider>()
        .updateCurrentColorSelectedId(widget.prevSchedule.colorCode);
    context
        .watch<ScheduleProvider>()
        .updateCurrentStatTime(widget.prevSchedule.startTime);
    context
        .watch<ScheduleProvider>()
        .updateCurrentEndTime(widget.prevSchedule.endTime);
    context
        .watch<ScheduleProvider>()
        .updateCurrentContent(widget.prevSchedule.content);
  }
}

typedef ContentSetter = void Function(String content);
typedef ColorIdSetter = void Function(int id);
typedef TimeSetter = void Function(int time);

class _BottomSheetHeader extends StatelessWidget {
  const _BottomSheetHeader();

  @override
  Widget build(BuildContext context) {
    String title = context
        .read<ScheduleProvider>()
        .currentDateTime
        .toFormattedString(Strings.DATE_FORMAT);
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
          child: TimeInputField(
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

class _EditScheduleButton extends StatelessWidget {
  const _EditScheduleButton();

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.read<ScheduleProvider>();
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            onPressEditEvent(scheduleProvider, context);
          },
          style: Styles.normalButtonStyle,
          child: const Text(
            Strings.EDIT,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  void onPressEditEvent(scheduleProvider, context) {
    if (scheduleProvider.isFieldInputValid()) {
      scheduleProvider.editSchedule();
      Navigator.of(context).pop();
    }
  }
}
