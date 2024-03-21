part of 'calendar.dart';

class _DefaultDay extends StatelessWidget {
  final DateTime day;
  final Color? backgroundColor;
  final TextStyle textStyle;

  const _DefaultDay({
    super.key,
    required this.day,
    this.backgroundColor,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        width: DefaultComponent.defaultCalendarDayWidth,
        height: DefaultComponent.defaultCalendarDayHeight,
        child: Center(
          child: Text(
            "${day.day}",
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
