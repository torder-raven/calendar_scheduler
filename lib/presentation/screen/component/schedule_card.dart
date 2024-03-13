import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:flutter/material.dart';
import 'default_component.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final int color;

  const ScheduleCard({
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DefaultComponent.defaultCardDecoration,
      child: Padding(
        padding: DefaultComponent.defaultPaddingSize,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(
                startTime: startTime,
                endTime: endTime,
                color: color,
              ),
              DefaultComponent.defaultSizedBox,
              _Content(
                content: content,
              ),
              DefaultComponent.defaultSizedBox,
              _Category(
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;
  final int color;

  const _Time({
    required this.startTime,
    required this.endTime,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${startTime.intTimeToTimeString()}~",
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: Color(color)),
        ),
        Text(
          endTime.intTimeToTimeString(),
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: Color(color)),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        content,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}

class _Category extends StatelessWidget {
  final int color;

  const _Category({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(color),
        shape: BoxShape.circle,
      ),
      width: DefaultComponent.defaultCircleSize,
      height: DefaultComponent.defaultCircleSize,
    );
  }
}
