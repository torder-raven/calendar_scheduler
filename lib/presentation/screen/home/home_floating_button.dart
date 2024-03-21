part of 'home_screen.dart';

FloatingActionButton _floatingActionButton({
  required BuildContext context,
  required DateTime selectedDay,
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
          return ScheduleRegisterBottomSheet(
            selectedDate: selectedDay,
          );
        },
      );
    },
    backgroundColor: ColorResource.PRIMARY_COLOR,
    child: const Icon(Icons.add),
  );
}
