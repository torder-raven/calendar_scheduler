import 'package:calendar_scheduler/di/locator.dart';
import 'package:calendar_scheduler/domain/usecase/get_schedule_by_color.dart';
import 'package:calendar_scheduler/presentation/const/colors.dart';
import 'package:calendar_scheduler/presentation/const/strings.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_item_builder.dart';
import 'package:flutter/material.dart';

import '../component/field/color_selection_field.dart';

class ScheduleFilterScreen extends StatefulWidget {
  const ScheduleFilterScreen({super.key});

  @override
  State<ScheduleFilterScreen> createState() => _ScheduleFilterScreenState();
}

class _ScheduleFilterScreenState extends State<ScheduleFilterScreen> {
  final _colors = ColorResource.selectorColors;
  late int _selectedColorId;

  @override
  void initState() {
    super.initState();
    _selectedColorId = _colors.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.SCHEDULE_FILTER_TITLE),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ColorSelectionField(
                colors: _colors,
                selectedColorId: _selectedColorId,
                colorIdSetter: selectedColor,
              ),
            ),
            DefaultComponent.defaultSizedBoxWithHeightSmall,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _ScheduleListView(
                  selectedColorId: _selectedColorId,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectedColor(int id) {
    setState(() {
      _selectedColorId = id;
    });
  }
}

class _ScheduleListView extends StatelessWidget {
  final int selectedColorId;

  const _ScheduleListView({super.key, required this.selectedColorId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder(
      future: serviceLocator<GetScheduleByColorUsecase>()
          .invoke(colorCode: selectedColorId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final list = snapshot.requireData;

        if (list.isEmpty) {
          return Center(
            child: Text(
              Strings.EMPTY_SCHEDULE,
              style: theme.textTheme.bodyMedium,
            ),
          );
        }

        return ListView.separated(
          itemCount: list.length,
          separatorBuilder: (context, index) {
            return DefaultComponent.defaultSizedBoxWithHeight;
          },
          itemBuilder: (context, index) => NormalItem(schedule: list[index]),
        );
      },
    );
  }
}
