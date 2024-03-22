import 'package:calendar_scheduler/domain/entity/schedule.dart';

abstract interface class ScheduleRepository {
  Future<void> deleteSchedule({required int scheduleId});
  Future<void> temporaryDeleteSchedule({required int scheduleId});
  Future<void> updateSchedule({required Schedule schedule});
  Future<void> registerSchedule({required Schedule schedule});
  Stream<List<Schedule>> getAllSchedule({required DateTime date});
  Future<List<Schedule>> getScheduleByColor({required int colorCode});
  Future<Map<DateTime, List<Schedule>>> getSchedule({required DateTime start, required DateTime end});
  Stream<List<Schedule>> getTemporaryDeleteSchedule();
  Future<List<Schedule>> searchSingleSchedule({required String keyword});
}
