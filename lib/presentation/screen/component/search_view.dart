import 'package:calendar_scheduler/di/locator.dart';
import 'package:calendar_scheduler/domain/usecase/search_single_schedule.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_item_builder.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_list_view.dart';
import 'package:flutter/material.dart';
import '../../../domain/entity/schedule.dart';
import '../../const/strings.dart';
import 'default_component.dart';

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () =>
              {if (query.isEmpty) close(context, null) else query = ''},
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: DefaultComponent.defaultSmallPaddingSize,
        child: _buildSearchResult(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Schedule> suggestions = [];

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion.content),
            onTap: () {},
          );
        });
  }

  Widget _buildSearchResult() {
    return FutureBuilder(
      future:
          serviceLocator<SearchSingleScheduleUsecase>().invoke(keyword: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else return _handleSearchResult(snapshot);
      },
    );
  }

  Widget _handleSearchResult(AsyncSnapshot snapshot) {
    if (snapshot.hasData && snapshot.data.isEmpty) {
      return Center(
        child: Text(
          Strings.EMPTY_SCHEDULE,
        ),
      );
    } else {
      final list = snapshot.requireData;
      return _buildListView(list);
    }
  }

  Widget _buildListView(List<Schedule> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => Padding(
        padding: DefaultComponent.defaultSmallPaddingSize,
        child: GestureDetector(
          onTap: () {
            showEditBottomSheet(context, list[index]);
          },
          child: NormalItem(schedule: list[index]),
        ),
      ),
    );
  }
}
