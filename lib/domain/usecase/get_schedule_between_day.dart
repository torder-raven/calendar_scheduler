import '../entity/schedule.dart';
import '../repository/schedule_repository.dart';

class GetScheduleBetweenDayUsecase {
  final ScheduleRepository _repository;

  GetScheduleBetweenDayUsecase({required ScheduleRepository repository})
      : _repository = repository;

  Stream<Map<DateTime, List<Schedule>>> invoke({
    required DateTime startDay,
    required DateTime endDay,
  }) =>
      _repository.getScheduleBetweenDay(
        start: startDay,
        end: endDay,
      );
}
