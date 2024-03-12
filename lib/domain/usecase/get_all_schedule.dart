import 'package:calendar_scheduler/domain/entity/schedule.dart';
import '../repository/schedule_repository.dart';

class GetAllScheduleUsecase {
  final ScheduleRepository _repository;

  GetAllScheduleUsecase({required ScheduleRepository repository}) : _repository = repository;

  Future<List<Schedule>> invoke() async => await _repository.getAllSchedule();
}