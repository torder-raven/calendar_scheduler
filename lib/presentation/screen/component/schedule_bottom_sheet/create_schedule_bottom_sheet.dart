import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:calendar_scheduler/presentation/screen/component/bottom_sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/strings.dart';
import '../../../const/styles.dart';
import '../../provider/schedule_provider.dart';
import '../field/color_selection_field.dart';
import '../field/content_input_field.dart';
import '../field/start_end_time_input_field.dart';

class CreateScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;

  const CreateScheduleBottomSheet({super.key, required this.selectedDate});

  @override
  State<CreateScheduleBottomSheet> createState() =>
      _CreateScheduleBottomSheetState();
}

class _CreateScheduleBottomSheetState extends State<CreateScheduleBottomSheet> {
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
            const _SaveScheduleButton(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initPrevCurrentScheduleData() {
    context
        .watch<ScheduleProvider>()
        .updateCurrentDateTime(widget.selectedDate);
  }
}

class _SaveScheduleButton extends StatelessWidget {
  const _SaveScheduleButton();

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.read<ScheduleProvider>();
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            onPressSaveEvent(scheduleProvider, context);
          },
          style: Styles.normalButtonStyle,
          child: const Text(
            Strings.SAVE,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  void onPressSaveEvent(scheduleProvider, context) {
    if (scheduleProvider.isFieldInputValid()) {
      scheduleProvider.saveSchedule();
      Navigator.of(context).pop();
    }
  }
}
