import 'package:calendar_scheduler/domain/repository/schedule_repository.dart';
import '../entity/schedule.dart';

class TemporaryDeleteScheduleUsecase {
  final ScheduleRepository _repository;

  TemporaryDeleteScheduleUsecase({required ScheduleRepository repository}) : _repository = repository;

  Future<void> invoke({required Schedule schedule}) async => await _repository.temporaryDeleteSchedule(schedule: schedule);
}