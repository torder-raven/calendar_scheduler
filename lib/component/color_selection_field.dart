import 'package:flutter/material.dart';

import '../presentation/const/colors.dart';
import '../presentation/const/strings.dart';

class ColorSelectionField extends StatefulWidget {
  final int colorCode;
  const ColorSelectionField({super.key, required this.colorCode});

  @override
  State<ColorSelectionField> createState() => _ColorSelectionFieldState();
}

class _ColorSelectionFieldState extends State<ColorSelectionField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.LABEL_COLOR,
          style: TextStyle(
            color: ColorResource.INPUT_TEXT_LABEL_COLOR,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        renderColors()
      ],
    );
  }

  Row renderColors() {
    return Row(
      children: List.generate(ColorResource.selectorColors.length, (index) {
        return Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Container(
            height: 30.0,
            width: 30.0,
            color: ColorResource.selectorColors[index],
          ),
        );
      }),
    );
  }
}
