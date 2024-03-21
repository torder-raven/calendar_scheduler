import 'package:calendar_scheduler/presentation/screen/component/bottom_sheet_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entity/schedule.dart';
import '../../../const/colors.dart';
import '../../../const/strings.dart';
import '../../../const/styles.dart';
import '../../provider/schedule_provider.dart';
import '../field/color_selection_field.dart';
import '../field/content_input_field.dart';
import '../field/start_end_time_input_field.dart';

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
            const BottomSheetHeader(),
            ColorSelectionField(
              colors: colors,
              selectedColorId:
                  context.watch<ScheduleProvider>().currentSelectedColorId,
              colorIdSetter: (int id) {
                context
                    .read<ScheduleProvider>()
                    .updateCurrentColorSelectedId(id);
              },
            ),
            const Spacer(),
            const StartEndTimeInputField(),
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
