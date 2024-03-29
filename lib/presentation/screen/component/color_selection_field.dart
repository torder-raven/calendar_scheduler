import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_register_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../const/strings.dart';
import '../../const/styles.dart';

class ColorSelectionField extends StatelessWidget {
  final List<Color> colors;
  final int selectedColorId;
  final ColorIdSetter colorIdSetter;

  const ColorSelectionField({
    super.key,
    required this.colors,
    required this.selectedColorId,
    required this.colorIdSetter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.LABEL_COLOR,
          style: Styles.inputLabelTextStyle,
        ),
        const SizedBox(
          height: 6.0,
        ),
        renderColors()
      ],
    );
  }

  Row renderColors() {
    return Row(
      children: List.generate(colors.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              colorIdSetter(colors[index].value);
            },
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                image: colors[index].value == selectedColorId
                    ? DecorationImage(
                        image: AssetImage("img_check".convertToPngFileFormat()),
                      )
                    : null,
                shape: BoxShape.circle,
                color: colors[index],
              ),
            ),
          ),
        );
      }),
    );
  }
}
