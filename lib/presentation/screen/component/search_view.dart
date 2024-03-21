import 'package:calendar_scheduler/di/locator.dart';
import 'package:calendar_scheduler/domain/entity/schedule.dart';
import 'package:calendar_scheduler/domain/usecase/search_single_schedule.dart';
import 'package:calendar_scheduler/presentation/const/strings.dart';
import 'package:calendar_scheduler/presentation/screen/component/default_component.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_item_builder.dart';
import 'package:calendar_scheduler/presentation/screen/component/schedule_list_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/keys.dart';

class SearchView extends SearchDelegate {
  late SharedPreferences _prefs;

  SearchView() {
    _initPrefs();
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
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
    return Padding(
      padding: DefaultComponent.defaultSmallPaddingSize,
      child: _buildSearchResult(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _getRecentKeyword(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final suggestions = snapshot.data!
              .where((element) => element.contains(query))
              .toList();
          return _buildSearchSuggestionTile(suggestions);
        }
        return Container();
      },
    );
  }

  Widget _buildSearchResult() {
    return FutureBuilder<List<Schedule>>(
      future:
          serviceLocator<SearchSingleScheduleUsecase>().invoke(keyword: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _handleSearchResult(snapshot);
        }
      },
    );
  }

  Widget _handleSearchResult(AsyncSnapshot<List<Schedule>> snapshot) {
    if (snapshot.hasData && snapshot.data!.isEmpty) {
      return Center(
        child: Text(
          Strings.EMPTY_SCHEDULE,
        ),
      );
    } else {
      _saveRecentKeyword(query);
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

  Widget _buildSearchSuggestionTile(List<String> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
          },
        );
      },
    );
  }

  _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _saveRecentKeyword(String keyword) async {
    Set<String> newList =
        _prefs.getStringList(Keys.RECENT_KEYWORD_LIST_KEY)?.toSet() ?? {};
    newList.add(keyword);
    _prefs.setStringList(Keys.RECENT_KEYWORD_LIST_KEY, newList.toList());
  }

  Future<List<String>> _getRecentKeyword() async =>
      _prefs.getStringList(Keys.RECENT_KEYWORD_LIST_KEY) ?? [];
}
