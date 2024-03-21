import 'package:flutter/material.dart';

import '../../../const/strings.dart';
import '../../../const/styles.dart';

class ColorSelectionField extends StatefulWidget {
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
  State<ColorSelectionField> createState() => _ColorSelectionFieldState();
}

class _ColorSelectionFieldState extends State<ColorSelectionField> {
  int? _selectedColorId;

  @override
  void initState() {
    super.initState();
    _selectedColorId = widget.selectedColorId;
  }

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
      children: List.generate(widget.colors.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedColorId = widget.colors[index].value;
                widget.colorIdSetter(_selectedColorId!);
              });
            },
            child: Stack(children: [
              Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.colors[index],
                ),
                child: widget.colors[index].value == _selectedColorId
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

typedef ColorIdSetter = void Function(int id);
