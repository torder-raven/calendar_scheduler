import 'package:calendar_scheduler/domain/entity/schedule.dart';
import '../repository/schedule_repository.dart';

class RegisterScheduleUsecase {
  final ScheduleRepository _repository;

  RegisterScheduleUsecase({required ScheduleRepository repository}) : _repository = repository;

  Future<void> invoke({required Schedule schedule}) => _repository.registerSchedule(schedule: schedule);
}