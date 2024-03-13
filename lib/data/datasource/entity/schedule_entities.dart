import 'package:drift/drift.dart';

import '../drift_database.dart';

/**
 * 일정 데이터 모델
 */
class ScheduleEntities extends Table {
  // 일정 PK
  IntColumn get id => integer().autoIncrement()();

  // 일정 내용
  TextColumn get content => text()();

  // 특정 일정 데이터
  DateTimeColumn get date => dateTime()();

  // 일정 시작 시간
  IntColumn get startTime => integer()();

  // 일정 끝 시간
  IntColumn get endTime => integer()();

  // 일정 컬러 코드
  IntColumn get colorHexCode => integer()();

  // 삭제된 일정인지?
  BoolColumn get isDeleted => boolean().clientDefault(() => false)();

  // 일정 생성 일자
  DateTimeColumn get createAt =>
      dateTime().clientDefault(() => DateTime.now())();
}