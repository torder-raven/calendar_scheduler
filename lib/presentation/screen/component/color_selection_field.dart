import 'package:calendar_scheduler/presentation/screen/component/schedule_register_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../const/strings.dart';

class ColorSelectionField extends StatefulWidget {
  final int? selectedColorId;
  final ColorIdSetter colorIdSetter;
  const ColorSelectionField(
      {super.key, this.selectedColorId, required this.colorIdSetter});

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
    List<Color> colors = ColorResource.selectorColors;
    return Row(
      children: List.generate(colors.length, (index) {
        return Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.colorIdSetter(colors[index].value);
              });
            },
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                image: colors[index].value == widget.selectedColorId
                    ? DecorationImage(
                        image: AssetImage(
                          "asset/img/img_check.png",
                        ),
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
