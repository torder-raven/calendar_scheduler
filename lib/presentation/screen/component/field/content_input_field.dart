import 'package:flutter/material.dart';

import '../../../const/colors.dart';
import '../../../const/strings.dart';
import '../../../const/styles.dart';

class ContentInputField extends StatefulWidget {
  final String initialContent;
  final ContentSetter contentSetter;
  const ContentInputField({
    super.key,
    required this.contentSetter,
    required this.initialContent,
  });

  @override
  State<ContentInputField> createState() => _ContentInputFieldState();
}

class _ContentInputFieldState extends State<ContentInputField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.initialContent;
    _textEditingController.addListener(() {
      widget.contentSetter(_textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.LABEL_CONTENT,
          style: Styles.inputLabelTextStyle,
        ),
        const SizedBox(
          height: 6.0,
        ),
        TextField(
          controller: _textEditingController,
          cursorColor: Colors.grey,
          maxLines: 3,
          style: Styles.inputTextStyle.copyWith(fontSize: 14.0),
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            enabledBorder: Styles.inputTextOutlineInputBorder,
            focusedBorder: Styles.inputTextOutlineInputBorder,
            filled: false,
            fillColor: Colors.white,
            hintText: Strings.CONTENT_HINT_TEXT,
            hintStyle: Styles.inputTextStyle.copyWith(
              color: ColorResource.INPUT_TEXT_FIELD_HINT_COLOR,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

typedef ContentSetter = void Function(String content);
