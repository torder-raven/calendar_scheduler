import 'package:flutter/material.dart';

import '../../../const/strings.dart';
import '../../../const/styles.dart';
import '../../schedule_bottom_sheet/create_schedule_bottom_sheet.dart';

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
            child: Stack(children: [
              Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors[index],
                ),
                child: colors[index].value == selectedColorId
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                    : null,
              ),
            ]),
          ),
        );
      }),
    );
  }
}
