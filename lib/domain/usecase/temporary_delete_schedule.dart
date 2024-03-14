import 'package:calendar_scheduler/domain/repository/schedule_repository.dart';
import '../entity/schedule.dart';

class TemporaryDeleteScheduleUsecase {
  final ScheduleRepository _repository;

  TemporaryDeleteScheduleUsecase({required ScheduleRepository repository}) : _repository = repository;

  Future<void> invoke({required int scheduleId}) => _repository.temporaryDeleteSchedule(scheduleId: scheduleId);
}