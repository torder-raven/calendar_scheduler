part of 'home_screen.dart';

FloatingActionButton _floatingActionButton({
  required BuildContext context,
}) {
  return FloatingActionButton(
    onPressed: () => _onClickFloatingActionButton(context: context),
    backgroundColor: ColorResource.PRIMARY_COLOR,
    child: const Icon(Icons.edit, color: Colors.white,),
  );
}

void _onClickFloatingActionButton({required BuildContext context}) {
  showModalBottomSheet<bool?>(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (_) {
      return ChangeNotifierProvider<ScheduleProvider>(
        create: (BuildContext context) => ScheduleProvider(),
        child: CreateScheduleBottomSheet(
          selectedDate: context.read<CalendarProvider>().selectedDay,
        ),
      );
    },
  );
}
