// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $ScheduleEntitiesTable extends ScheduleEntities
    with TableInfo<$ScheduleEntitiesTable, ScheduleEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<int> startTime = GeneratedColumn<int>(
      'start_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<int> endTime = GeneratedColumn<int>(
      'end_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _colorHexCodeMeta =
      const VerificationMeta('colorHexCode');
  @override
  late final GeneratedColumn<int> colorHexCode = GeneratedColumn<int>(
      'color_hex_code', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      clientDefault: () => false);
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
      'is_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_done" IN (0, 1))'),
      clientDefault: () => false);
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<DateTime> createAt = GeneratedColumn<DateTime>(
      'create_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        content,
        date,
        startTime,
        endTime,
        colorHexCode,
        isDeleted,
        isDone,
        createAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_entities';
  @override
  VerificationContext validateIntegrity(Insertable<ScheduleEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('color_hex_code')) {
      context.handle(
          _colorHexCodeMeta,
          colorHexCode.isAcceptableOrUnknown(
              data['color_hex_code']!, _colorHexCodeMeta));
    } else if (isInserting) {
      context.missing(_colorHexCodeMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time'])!,
      colorHexCode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_hex_code'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isDone: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_done'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_at'])!,
    );
  }

  @override
  $ScheduleEntitiesTable createAlias(String alias) {
    return $ScheduleEntitiesTable(attachedDatabase, alias);
  }
}

class ScheduleEntity extends DataClass implements Insertable<ScheduleEntity> {
  final int id;
  final String content;
  final DateTime date;
  final int startTime;
  final int endTime;
  final int colorHexCode;
  final bool isDeleted;
  final bool isDone;
  final DateTime createAt;
  const ScheduleEntity(
      {required this.id,
      required this.content,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.colorHexCode,
      required this.isDeleted,
      required this.isDone,
      required this.createAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['date'] = Variable<DateTime>(date);
    map['start_time'] = Variable<int>(startTime);
    map['end_time'] = Variable<int>(endTime);
    map['color_hex_code'] = Variable<int>(colorHexCode);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_done'] = Variable<bool>(isDone);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  ScheduleEntitiesCompanion toCompanion(bool nullToAbsent) {
    return ScheduleEntitiesCompanion(
      id: Value(id),
      content: Value(content),
      date: Value(date),
      startTime: Value(startTime),
      endTime: Value(endTime),
      colorHexCode: Value(colorHexCode),
      isDeleted: Value(isDeleted),
      isDone: Value(isDone),
      createAt: Value(createAt),
    );
  }

  factory ScheduleEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleEntity(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      date: serializer.fromJson<DateTime>(json['date']),
      startTime: serializer.fromJson<int>(json['startTime']),
      endTime: serializer.fromJson<int>(json['endTime']),
      colorHexCode: serializer.fromJson<int>(json['colorHexCode']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'date': serializer.toJson<DateTime>(date),
      'startTime': serializer.toJson<int>(startTime),
      'endTime': serializer.toJson<int>(endTime),
      'colorHexCode': serializer.toJson<int>(colorHexCode),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isDone': serializer.toJson<bool>(isDone),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  ScheduleEntity copyWith(
          {int? id,
          String? content,
          DateTime? date,
          int? startTime,
          int? endTime,
          int? colorHexCode,
          bool? isDeleted,
          bool? isDone,
          DateTime? createAt}) =>
      ScheduleEntity(
        id: id ?? this.id,
        content: content ?? this.content,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        colorHexCode: colorHexCode ?? this.colorHexCode,
        isDeleted: isDeleted ?? this.isDeleted,
        isDone: isDone ?? this.isDone,
        createAt: createAt ?? this.createAt,
      );
  @override
  String toString() {
    return (StringBuffer('ScheduleEntity(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('colorHexCode: $colorHexCode, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDone: $isDone, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, date, startTime, endTime,
      colorHexCode, isDeleted, isDone, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleEntity &&
          other.id == this.id &&
          other.content == this.content &&
          other.date == this.date &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.colorHexCode == this.colorHexCode &&
          other.isDeleted == this.isDeleted &&
          other.isDone == this.isDone &&
          other.createAt == this.createAt);
}

class ScheduleEntitiesCompanion extends UpdateCompanion<ScheduleEntity> {
  final Value<int> id;
  final Value<String> content;
  final Value<DateTime> date;
  final Value<int> startTime;
  final Value<int> endTime;
  final Value<int> colorHexCode;
  final Value<bool> isDeleted;
  final Value<bool> isDone;
  final Value<DateTime> createAt;
  const ScheduleEntitiesCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.colorHexCode = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isDone = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  ScheduleEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required DateTime date,
    required int startTime,
    required int endTime,
    required int colorHexCode,
    this.isDeleted = const Value.absent(),
    this.isDone = const Value.absent(),
    this.createAt = const Value.absent(),
  })  : content = Value(content),
        date = Value(date),
        startTime = Value(startTime),
        endTime = Value(endTime),
        colorHexCode = Value(colorHexCode);
  static Insertable<ScheduleEntity> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<DateTime>? date,
    Expression<int>? startTime,
    Expression<int>? endTime,
    Expression<int>? colorHexCode,
    Expression<bool>? isDeleted,
    Expression<bool>? isDone,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (colorHexCode != null) 'color_hex_code': colorHexCode,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isDone != null) 'is_done': isDone,
      if (createAt != null) 'create_at': createAt,
    });
  }

  ScheduleEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? content,
      Value<DateTime>? date,
      Value<int>? startTime,
      Value<int>? endTime,
      Value<int>? colorHexCode,
      Value<bool>? isDeleted,
      Value<bool>? isDone,
      Value<DateTime>? createAt}) {
    return ScheduleEntitiesCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      colorHexCode: colorHexCode ?? this.colorHexCode,
      isDeleted: isDeleted ?? this.isDeleted,
      isDone: isDone ?? this.isDone,
      createAt: createAt ?? this.createAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<int>(endTime.value);
    }
    if (colorHexCode.present) {
      map['color_hex_code'] = Variable<int>(colorHexCode.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('colorHexCode: $colorHexCode, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDone: $isDone, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDataBase extends GeneratedDatabase {
  _$LocalDataBase(QueryExecutor e) : super(e);
  late final $ScheduleEntitiesTable scheduleEntities =
      $ScheduleEntitiesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scheduleEntities];
}
