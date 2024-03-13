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
              ),
              DefaultComponent.defaultSizedBoxWithWidth,
              _Content(
                content: content,
              ),
              DefaultComponent.defaultSizedBoxWithWidth,
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

  const _Time({
    required this.startTime,
    required this.endTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          startTime.intTimeToTimeString(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          endTime.intTimeToTimeString(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
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
        style: Theme.of(context).textTheme.bodyMedium,
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
