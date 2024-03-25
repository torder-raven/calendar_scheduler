import 'package:calendar_scheduler/presentation/extension.dart';
import 'package:calendar_scheduler/presentation/screen/component/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../../domain/entity/schedule.dart';
import '../../../const/colors.dart';
import '../../../const/strings.dart';
import '../../../const/styles.dart';
import '../../provider/schedule_provider.dart';
import '../default_component.dart';
import 'control_type.dart';
part 'date_control_dialog_builder.dart';
part 'date_picker_builder.dart';

class DateControlDialog {
  static void showDateControlDialog(BuildContext context, Schedule schedule) {
    showDialog(
      context: context,
      builder: (context) => _DateControlDialogBuilder(schedule: schedule),
    );
  }

  static void showScheduleDatePicker(
      BuildContext context, ControlType type, Schedule schedule) {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider(
        create: (BuildContext context) => ScheduleProvider(),
        child: _DatePickerBuilder(schedule: schedule, type: type),
      ),
    );
  }
}
