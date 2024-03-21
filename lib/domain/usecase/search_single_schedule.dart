import 'package:calendar_scheduler/domain/entity/schedule.dart';
import '../repository/schedule_repository.dart';

class SearchSingleScheduleUsecase {
  final ScheduleRepository _repository;

  SearchSingleScheduleUsecase({required ScheduleRepository repository}) : _repository = repository;

  Future<List<Schedule>> invoke({required String keyword}) => _repository.searchSingleSchedule(keyword: keyword);
}