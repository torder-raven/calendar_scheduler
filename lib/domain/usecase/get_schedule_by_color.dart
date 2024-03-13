import '../repository/schedule_repository.dart';

class GetScheduleByColorUsecase {
  final ScheduleRepository _repository;

  GetScheduleByColorUsecase({required ScheduleRepository repository}) : _repository = repository;

  Future<void> invoke({required int colorCode}) async => await _repository.getScheduleByColor(colorCode: colorCode);
}