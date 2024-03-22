import 'package:calendar_scheduler/presentation/screen/component/calendar/calendar.dart';
import 'package:calendar_scheduler/presentation/screen/component/calendar/provider/calendar_provider.dart';
import 'package:calendar_scheduler/presentation/screen/component/date_banner.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_list_view.dart';
import 'package:calendar_scheduler/presentation/screen/filter_screen/schedule_filter_screen.dart';
import 'package:calendar_scheduler/presentation/screen/temp_delete/temp_delete_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/colors.dart';
import '../../../const/strings.dart';
import '../../component/schedule_bottom_sheet/create_schedule_bottom_sheet.dart';
import '../../component/search_view.dart';
import '../../provider/schedule_provider.dart';

part 'home_app_bar.dart';

part 'home_floating_button.dart';

final _FIRST_DAY = DateTime.utc(1900);
final _LAST_DAY = DateTime.utc(3000);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CalendarProvider(),
      child: Consumer<CalendarProvider>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: _homeAppBar(
              onFilterPressed: goToFilterScheduleScreen,
              onDeletePressed: goToTempDeleteScreen,
              onSearchPressed: showSearchDelegate,
            ),
            floatingActionButton: _floatingActionButton(context: context),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Calendar(
                    firstDay: _FIRST_DAY,
                    lastDay: _LAST_DAY,
                  ),
                  DefaultComponent.defaultSizedBoxWithHeightSmall,
                  const DateBanner(),
                  DefaultComponent.defaultSizedBoxWithHeightSmall,
                  const ScheduleListView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goToFilterScheduleScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ScheduleFilterScreen();
        },
      ),
    );
  }

  void goToTempDeleteScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const TempDeleteScreen();
        },
      ),
    );
  }

  void showSearchDelegate() {
    showSearch(
      context: context,
      delegate: SearchView(),
    );
  }
}
