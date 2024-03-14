import 'package:calendar_scheduler/domain/entity/schedule.dart';
import '../repository/schedule_repository.dart';

class GetAllScheduleUsecase {
  final ScheduleRepository _repository;

  GetAllScheduleUsecase({required ScheduleRepository repository}) : _repository = repository;

  Stream<List<Schedule>> invoke(DateTime date) => _repository.getAllSchedule(date: date);
}