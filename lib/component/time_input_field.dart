import 'package:flutter/material.dart';

class TimeInputField extends StatefulWidget {
  const TimeInputField({super.key});

  @override
  State<TimeInputField> createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: [
        // Expanded(child: child),
        SizedBox(width: 4.0),
        // Expanded(child: child)
      ],
    );
  }


}
