part of 'home_screen.dart';

FloatingActionButton _floatingActionButton({
  required BuildContext context,
}) {
  return FloatingActionButton(
    onPressed: () {
      showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (_) {
          return ChangeNotifierProvider(
            create: (BuildContext context) => ScheduleProvider(),
            child: Consumer<CalendarProvider>(
              builder: (context, value, child) {
                return CreateScheduleBottomSheet(
                  selectedDate: context.read<CalendarProvider>().selectedDay,
                );
              },
            ),
          );
        },
      );
    },
    backgroundColor: ColorResource.PRIMARY_COLOR,
    child: const Icon(Icons.add),
  );
}
