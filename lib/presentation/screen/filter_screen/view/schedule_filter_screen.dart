import 'package:calendar_scheduler/presentation/const/strings.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_item_builder.dart';
import 'package:calendar_scheduler/presentation/screen/filter_screen/provider/color_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../component/field/color_selection_field.dart';

part 'schedule_filter_list.dart';

class ScheduleFilterScreen extends StatelessWidget {
  const ScheduleFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ColorFilterProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.SCHEDULE_FILTER_TITLE),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Consumer<ColorFilterProvider>(
                  builder: (context, provider, child) => ColorSelectionField(
                    colors: provider.colors,
                    selectedColorId: provider.selectedColorId,
                    colorIdSetter: provider.updateSelectedColorId,
                  ),
                ),
                DefaultComponent.defaultSizedBoxWithHeightSmall,
                const Expanded(child: _ScheduleFilterListView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
