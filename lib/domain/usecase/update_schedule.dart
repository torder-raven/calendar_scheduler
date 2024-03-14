import '../entity/schedule.dart';
import '../repository/schedule_repository.dart';

class UpdateScheduleUsecase {
  final ScheduleRepository _repository;

  UpdateScheduleUsecase({required ScheduleRepository repository}) : _repository = repository;

  Future<void> invoke({required Schedule schedule}) => _repository.updateSchedule(schedule: schedule);
}