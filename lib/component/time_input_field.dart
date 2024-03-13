import 'package:flutter/material.dart';

import '../presentation/const/colors.dart';

class TimeInputField extends StatefulWidget {
  final String selectedTimeType;
  const TimeInputField({super.key, required this.selectedTimeType});

  @override
  State<TimeInputField> createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  TextStyle textStyle = const TextStyle(
      color: ColorResource.INPUT_TEXT_FIELD_FILL_COLOR,
      fontWeight: FontWeight.w400,
      fontSize: 13.0);

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: ColorResource.INPUT_TEXT_FIELD_BORDER_COLOR,
    ),
    borderRadius: BorderRadius.circular(8.0),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.selectedTimeType,
        ),
        TextField(
          cursorColor: Colors.grey,
          style: textStyle,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            filled: false,
            fillColor: Colors.white,
            hintText: "AM 00:00",
            hintStyle: textStyle.copyWith(
              color: ColorResource.INPUT_TEXT_FIELD_HINT_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}
