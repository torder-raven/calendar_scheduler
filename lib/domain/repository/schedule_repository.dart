import 'package:calendar_scheduler/domain/entity/schedule.dart';

abstract interface class ScheduleRepository {
  Future<void> deleteSchedule({required int scheduleId});
  Future<void> temporaryDeleteSchedule({required int scheduleId});
  Future<void> updateSchedule({required Schedule schedule});
  Future<void> registerSchedule({required Schedule schedule});
  Future<List<Schedule>> getAllSchedule({required DateTime date});
  Future<List<Schedule>> getScheduleByColor({required int colorCode});
  Future<List<Schedule>> getTemporaryDeleteSchedule();
}