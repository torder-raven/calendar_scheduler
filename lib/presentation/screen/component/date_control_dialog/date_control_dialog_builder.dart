part of 'date_control_dialog.dart';

class _DateControlDialogBuilder extends StatelessWidget {
  final Schedule schedule;

  const _DateControlDialogBuilder({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.white,
      child: Container(
        padding: DefaultComponent.defaultPaddingSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            renderDateControlActionButton(
              context,
              ControlType.REPEAT_SCHEDULE_ON_OTHER_DATE,
            ),
            renderDateControlActionButton(
              context,
              ControlType.CHANGE_SCHEDULE_DATE,
            ),
            renderCloseActionButton(context)
          ],
        ),
      ),
    );
  }

  Widget renderDateControlActionButton(BuildContext context, ControlType type) {
    return ElevatedButton(
      onPressed: () {
        DateControlDialog.showScheduleDatePicker(context, type, schedule);
      },
      style: Styles.dialogButtonStyle,
      child: Text(
        type.displayName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget renderCloseActionButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
      ),
      child: const Text(
        Strings.CLOSE,
        style: TextStyle(
          color: ColorResource.BUTTON_NORMAL_COLOR,
        ),
      ),
    );
  }
}
