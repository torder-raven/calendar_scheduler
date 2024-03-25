part of 'date_control_dialog.dart';

class _DatePickerBuilder extends StatelessWidget {
  DateTime? selectedDateTime;
  final Schedule schedule;
  final ControlType type;

  _DatePickerBuilder({
    required this.schedule,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    selectedDateTime = schedule.date;
    return CustomDatePicker(
      dialogContent: datePickerDialogContent((DateTime value) {
        selectedDateTime = value.toUtcDate();
      }, selectedDateTime!),
      cancelButton: renderCancelButton(context),
      confirmButton: renderConfirmButton(context),
    );
  }

  Widget datePickerDialogContent(
      Function(DateTime) onDateTimeChanged, DateTime selectedDateTime) {
    return CupertinoDatePicker(
      initialDateTime: schedule.date,
      dateOrder: DatePickerDateOrder.ymd,
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: onDateTimeChanged,
    );
  }

  Widget renderCancelButton(context) {
    return Expanded(
      flex: 1,
      child: ElevatedButton(
        onPressed: () {
          dismissAllDialogs(context);
        },
        style: Styles.cancelButtonStyle,
        child: const Text(
          Strings.CANCEL_TEXT,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget renderConfirmButton(context) {
    return Expanded(
      flex: 2,
      child: ElevatedButton(
        onPressed: () async {
          loadScheduleEventByControlType(context);
          dismissAllDialogs(context);
        },
        style: Styles.confirmButtonStyle,
        child: const Text(
          Strings.CONFIRM,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void loadScheduleEventByControlType(context) {
    if (type == ControlType.REPEAT_SCHEDULE_ON_OTHER_DATE) {
      repeatSchedule(context);
    } else {
      changeScheduleDate(context);
    }
  }

  void repeatSchedule(context) {
    Provider.of<ScheduleProvider>(context, listen: false)
        .repeatSchedule(selectedDateTime, schedule);
  }

  void changeScheduleDate(context) {
    Provider.of<ScheduleProvider>(context, listen: false)
        .changeScheduleDate(selectedDateTime, schedule);
  }

  void dismissAllDialogs(context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
