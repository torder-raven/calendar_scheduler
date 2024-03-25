part of 'calendar.dart';

Widget? _markerBuilder(BuildContext context, DateTime day, List events) {
  if (events.isEmpty) return null;

  return Positioned(
    right: 0,
    bottom: 0,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorResource.SECONDARY_COLOR,
      ),
      child: Text(
        "${events.length}",
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    ),
  );
}
