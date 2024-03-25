part of 'schedule_filter_screen.dart';

class _ScheduleFilterListView extends StatelessWidget {
  const _ScheduleFilterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorFilterProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.getScheduleByColor(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return showLoading();
            }

            final list = snapshot.requireData;

            if (list.isEmpty) {
              return showEmptyView(context);
            }

            return ListView.separated(
              itemCount: list.length,
              separatorBuilder: (context, index) {
                return DefaultComponent.defaultSizedBoxWithHeight;
              },
              itemBuilder: (context, index) =>
                  NormalItem(schedule: list[index]),
            );
          },
        );
      },
    );
  }

  Widget showLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showEmptyView(BuildContext context) {
    return Center(
      child: Text(
        Strings.EMPTY_SCHEDULE,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
