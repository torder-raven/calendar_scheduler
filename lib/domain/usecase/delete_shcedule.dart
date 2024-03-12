import '../entity/schedule.dart';
import '../repository/schedule_repository.dart';

class DeleteScheduleUsecase {
  final ScheduleRepository _repository;

  DeleteScheduleUsecase({required ScheduleRepository repository}) : _repository = repository;

  Future<void> invoke({required int scheduleId}) async => await _repository.deleteSchedule(scheduleId: scheduleId);
}