import '../entity/schedule.dart';
import '../repository/schedule_repository.dart';

class GetTemporaryDeleteScheduleUsecase {
  final ScheduleRepository _repository;

  GetTemporaryDeleteScheduleUsecase({required ScheduleRepository repository}) : _repository = repository;

  Future<List<Schedule>> invoke() async => await _repository.getTemporaryDeleteSchedule();
}