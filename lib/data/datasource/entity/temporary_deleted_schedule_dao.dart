import 'package:drift/drift.dart';

class TemporaryDeletedScheduleDao extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text()();

  DateTimeColumn get date => dateTime()();

  IntColumn get startTime => integer()();

  IntColumn get endTime => integer()();

  IntColumn get colorCode => integer()();

  DateTimeColumn get createAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
