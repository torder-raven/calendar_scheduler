import 'package:flutter/material.dart';

import '../presentation/const/colors.dart';
import '../presentation/const/strings.dart';


class ContentInputField extends StatelessWidget {
  const ContentInputField({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
        color: ColorResource.INPUT_TEXT_FIELD_FILL_COLOR,
        fontWeight: FontWeight.w400,
        fontSize: 14.0);

    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: ColorResource.INPUT_TEXT_FIELD_BORDER_COLOR,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.LABEL_CONTENT,
          style: textStyle,
        ),
        const SizedBox(
          height: 6.0,
        ),
        TextField(
          cursorColor: Colors.grey,
          maxLines: 3,
          style: textStyle,
          decoration: InputDecoration(
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            filled: false,
            fillColor: Colors.white,
            hintText: Strings.CONTENT_HINT_TEXT,
            hintStyle: textStyle.copyWith(
              color: ColorResource.INPUT_TEXT_FIELD_HINT_COLOR,
            ),
          ),
        )
      ],
    );
  }
}
