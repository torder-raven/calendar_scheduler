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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                height: 210,
                child: CupertinoDatePicker(
                  initialDateTime: schedule.date,
                  dateOrder: DatePickerDateOrder.ymd,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime value) {
                    selectedDateTime = value.toUtcDate();
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  renderCancelButton(context),
                  const SizedBox(
                    width: 8,
                  ),
                  renderConfirmButton(context)
                ],
              ),
            ),
          ],
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

  void dismissAllDialogs(context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
