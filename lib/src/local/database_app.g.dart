// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_app.dart';

// ignore_for_file: type=lint
class $BabyInforEntityTable extends BabyInforEntity
    with TableInfo<$BabyInforEntityTable, BabyInforEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BabyInforEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, date, gender, weight, height];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'baby_infor_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<BabyInforEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BabyInforEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BabyInforEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height']),
    );
  }

  @override
  $BabyInforEntityTable createAlias(String alias) {
    return $BabyInforEntityTable(attachedDatabase, alias);
  }
}

class BabyInforEntityData extends DataClass
    implements Insertable<BabyInforEntityData> {
  final String id;
  final String name;
  final String type;
  final DateTime date;
  final String? gender;
  final double? weight;
  final double? height;
  const BabyInforEntityData(
      {required this.id,
      required this.name,
      required this.type,
      required this.date,
      this.gender,
      this.weight,
      this.height});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    return map;
  }

  BabyInforEntityCompanion toCompanion(bool nullToAbsent) {
    return BabyInforEntityCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      date: Value(date),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
    );
  }

  factory BabyInforEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BabyInforEntityData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
      gender: serializer.fromJson<String?>(json['gender']),
      weight: serializer.fromJson<double?>(json['weight']),
      height: serializer.fromJson<double?>(json['height']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
      'gender': serializer.toJson<String?>(gender),
      'weight': serializer.toJson<double?>(weight),
      'height': serializer.toJson<double?>(height),
    };
  }

  BabyInforEntityData copyWith(
          {String? id,
          String? name,
          String? type,
          DateTime? date,
          Value<String?> gender = const Value.absent(),
          Value<double?> weight = const Value.absent(),
          Value<double?> height = const Value.absent()}) =>
      BabyInforEntityData(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        date: date ?? this.date,
        gender: gender.present ? gender.value : this.gender,
        weight: weight.present ? weight.value : this.weight,
        height: height.present ? height.value : this.height,
      );
  @override
  String toString() {
    return (StringBuffer('BabyInforEntityData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('gender: $gender, ')
          ..write('weight: $weight, ')
          ..write('height: $height')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, date, gender, weight, height);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BabyInforEntityData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.date == this.date &&
          other.gender == this.gender &&
          other.weight == this.weight &&
          other.height == this.height);
}

class BabyInforEntityCompanion extends UpdateCompanion<BabyInforEntityData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<DateTime> date;
  final Value<String?> gender;
  final Value<double?> weight;
  final Value<double?> height;
  final Value<int> rowid;
  const BabyInforEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.gender = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BabyInforEntityCompanion.insert({
    required String id,
    required String name,
    required String type,
    required DateTime date,
    this.gender = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        date = Value(date);
  static Insertable<BabyInforEntityData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<DateTime>? date,
    Expression<String>? gender,
    Expression<double>? weight,
    Expression<double>? height,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (gender != null) 'gender': gender,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BabyInforEntityCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<DateTime>? date,
      Value<String?>? gender,
      Value<double?>? weight,
      Value<double?>? height,
      Value<int>? rowid}) {
    return BabyInforEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      date: date ?? this.date,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BabyInforEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('gender: $gender, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesEntityTable extends NotesEntity
    with TableInfo<$NotesEntityTable, NotesEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remindTimeMeta =
      const VerificationMeta('remindTime');
  @override
  late final GeneratedColumn<DateTime> remindTime = GeneratedColumn<DateTime>(
      'remind_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _medicineMeta =
      const VerificationMeta('medicine');
  @override
  late final GeneratedColumn<String> medicine = GeneratedColumn<String>(
      'medicine', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hospitalMeta =
      const VerificationMeta('hospital');
  @override
  late final GeneratedColumn<String> hospital = GeneratedColumn<String>(
      'hospital', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
      'detail', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, type, time, date, remindTime, medicine, hospital, detail];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes_entity';
  @override
  VerificationContext validateIntegrity(Insertable<NotesEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('remind_time')) {
      context.handle(
          _remindTimeMeta,
          remindTime.isAcceptableOrUnknown(
              data['remind_time']!, _remindTimeMeta));
    }
    if (data.containsKey('medicine')) {
      context.handle(_medicineMeta,
          medicine.isAcceptableOrUnknown(data['medicine']!, _medicineMeta));
    }
    if (data.containsKey('hospital')) {
      context.handle(_hospitalMeta,
          hospital.isAcceptableOrUnknown(data['hospital']!, _hospitalMeta));
    }
    if (data.containsKey('detail')) {
      context.handle(_detailMeta,
          detail.isAcceptableOrUnknown(data['detail']!, _detailMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotesEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotesEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      remindTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}remind_time']),
      medicine: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicine']),
      hospital: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hospital']),
      detail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detail']),
    );
  }

  @override
  $NotesEntityTable createAlias(String alias) {
    return $NotesEntityTable(attachedDatabase, alias);
  }
}

class NotesEntityData extends DataClass implements Insertable<NotesEntityData> {
  final String id;
  final String title;
  final String type;
  final DateTime? time;
  final String date;
  final DateTime? remindTime;
  final String? medicine;
  final String? hospital;
  final String? detail;
  const NotesEntityData(
      {required this.id,
      required this.title,
      required this.type,
      this.time,
      required this.date,
      this.remindTime,
      this.medicine,
      this.hospital,
      this.detail});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<DateTime>(time);
    }
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || remindTime != null) {
      map['remind_time'] = Variable<DateTime>(remindTime);
    }
    if (!nullToAbsent || medicine != null) {
      map['medicine'] = Variable<String>(medicine);
    }
    if (!nullToAbsent || hospital != null) {
      map['hospital'] = Variable<String>(hospital);
    }
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    return map;
  }

  NotesEntityCompanion toCompanion(bool nullToAbsent) {
    return NotesEntityCompanion(
      id: Value(id),
      title: Value(title),
      type: Value(type),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      date: Value(date),
      remindTime: remindTime == null && nullToAbsent
          ? const Value.absent()
          : Value(remindTime),
      medicine: medicine == null && nullToAbsent
          ? const Value.absent()
          : Value(medicine),
      hospital: hospital == null && nullToAbsent
          ? const Value.absent()
          : Value(hospital),
      detail:
          detail == null && nullToAbsent ? const Value.absent() : Value(detail),
    );
  }

  factory NotesEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotesEntityData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      time: serializer.fromJson<DateTime?>(json['time']),
      date: serializer.fromJson<String>(json['date']),
      remindTime: serializer.fromJson<DateTime?>(json['remindTime']),
      medicine: serializer.fromJson<String?>(json['medicine']),
      hospital: serializer.fromJson<String?>(json['hospital']),
      detail: serializer.fromJson<String?>(json['detail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'time': serializer.toJson<DateTime?>(time),
      'date': serializer.toJson<String>(date),
      'remindTime': serializer.toJson<DateTime?>(remindTime),
      'medicine': serializer.toJson<String?>(medicine),
      'hospital': serializer.toJson<String?>(hospital),
      'detail': serializer.toJson<String?>(detail),
    };
  }

  NotesEntityData copyWith(
          {String? id,
          String? title,
          String? type,
          Value<DateTime?> time = const Value.absent(),
          String? date,
          Value<DateTime?> remindTime = const Value.absent(),
          Value<String?> medicine = const Value.absent(),
          Value<String?> hospital = const Value.absent(),
          Value<String?> detail = const Value.absent()}) =>
      NotesEntityData(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        time: time.present ? time.value : this.time,
        date: date ?? this.date,
        remindTime: remindTime.present ? remindTime.value : this.remindTime,
        medicine: medicine.present ? medicine.value : this.medicine,
        hospital: hospital.present ? hospital.value : this.hospital,
        detail: detail.present ? detail.value : this.detail,
      );
  @override
  String toString() {
    return (StringBuffer('NotesEntityData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('time: $time, ')
          ..write('date: $date, ')
          ..write('remindTime: $remindTime, ')
          ..write('medicine: $medicine, ')
          ..write('hospital: $hospital, ')
          ..write('detail: $detail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, type, time, date, remindTime, medicine, hospital, detail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotesEntityData &&
          other.id == this.id &&
          other.title == this.title &&
          other.type == this.type &&
          other.time == this.time &&
          other.date == this.date &&
          other.remindTime == this.remindTime &&
          other.medicine == this.medicine &&
          other.hospital == this.hospital &&
          other.detail == this.detail);
}

class NotesEntityCompanion extends UpdateCompanion<NotesEntityData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> type;
  final Value<DateTime?> time;
  final Value<String> date;
  final Value<DateTime?> remindTime;
  final Value<String?> medicine;
  final Value<String?> hospital;
  final Value<String?> detail;
  final Value<int> rowid;
  const NotesEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.time = const Value.absent(),
    this.date = const Value.absent(),
    this.remindTime = const Value.absent(),
    this.medicine = const Value.absent(),
    this.hospital = const Value.absent(),
    this.detail = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesEntityCompanion.insert({
    required String id,
    required String title,
    required String type,
    this.time = const Value.absent(),
    required String date,
    this.remindTime = const Value.absent(),
    this.medicine = const Value.absent(),
    this.hospital = const Value.absent(),
    this.detail = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        type = Value(type),
        date = Value(date);
  static Insertable<NotesEntityData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? type,
    Expression<DateTime>? time,
    Expression<String>? date,
    Expression<DateTime>? remindTime,
    Expression<String>? medicine,
    Expression<String>? hospital,
    Expression<String>? detail,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (time != null) 'time': time,
      if (date != null) 'date': date,
      if (remindTime != null) 'remind_time': remindTime,
      if (medicine != null) 'medicine': medicine,
      if (hospital != null) 'hospital': hospital,
      if (detail != null) 'detail': detail,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesEntityCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? type,
      Value<DateTime?>? time,
      Value<String>? date,
      Value<DateTime?>? remindTime,
      Value<String?>? medicine,
      Value<String?>? hospital,
      Value<String?>? detail,
      Value<int>? rowid}) {
    return NotesEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      time: time ?? this.time,
      date: date ?? this.date,
      remindTime: remindTime ?? this.remindTime,
      medicine: medicine ?? this.medicine,
      hospital: hospital ?? this.hospital,
      detail: detail ?? this.detail,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (remindTime.present) {
      map['remind_time'] = Variable<DateTime>(remindTime.value);
    }
    if (medicine.present) {
      map['medicine'] = Variable<String>(medicine.value);
    }
    if (hospital.present) {
      map['hospital'] = Variable<String>(hospital.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('time: $time, ')
          ..write('date: $date, ')
          ..write('remindTime: $remindTime, ')
          ..write('medicine: $medicine, ')
          ..write('hospital: $hospital, ')
          ..write('detail: $detail, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ArticlesEntityTable extends ArticlesEntity
    with TableInfo<$ArticlesEntityTable, ArticlesEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _summarizeMeta =
      const VerificationMeta('summarize');
  @override
  late final GeneratedColumn<String> summarize = GeneratedColumn<String>(
      'summarize', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, summarize, content, tag, author, link, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles_entity';
  @override
  VerificationContext validateIntegrity(Insertable<ArticlesEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('summarize')) {
      context.handle(_summarizeMeta,
          summarize.isAcceptableOrUnknown(data['summarize']!, _summarizeMeta));
    } else if (isInserting) {
      context.missing(_summarizeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArticlesEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticlesEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      summarize: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summarize'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag']),
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author']),
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
    );
  }

  @override
  $ArticlesEntityTable createAlias(String alias) {
    return $ArticlesEntityTable(attachedDatabase, alias);
  }
}

class ArticlesEntityData extends DataClass
    implements Insertable<ArticlesEntityData> {
  final String id;
  final String title;
  final String summarize;
  final String content;
  final String? tag;
  final String? author;
  final String? link;
  final String? image;
  const ArticlesEntityData(
      {required this.id,
      required this.title,
      required this.summarize,
      required this.content,
      this.tag,
      this.author,
      this.link,
      this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['summarize'] = Variable<String>(summarize);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<String>(tag);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    return map;
  }

  ArticlesEntityCompanion toCompanion(bool nullToAbsent) {
    return ArticlesEntityCompanion(
      id: Value(id),
      title: Value(title),
      summarize: Value(summarize),
      content: Value(content),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory ArticlesEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticlesEntityData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      summarize: serializer.fromJson<String>(json['summarize']),
      content: serializer.fromJson<String>(json['content']),
      tag: serializer.fromJson<String?>(json['tag']),
      author: serializer.fromJson<String?>(json['author']),
      link: serializer.fromJson<String?>(json['link']),
      image: serializer.fromJson<String?>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'summarize': serializer.toJson<String>(summarize),
      'content': serializer.toJson<String>(content),
      'tag': serializer.toJson<String?>(tag),
      'author': serializer.toJson<String?>(author),
      'link': serializer.toJson<String?>(link),
      'image': serializer.toJson<String?>(image),
    };
  }

  ArticlesEntityData copyWith(
          {String? id,
          String? title,
          String? summarize,
          String? content,
          Value<String?> tag = const Value.absent(),
          Value<String?> author = const Value.absent(),
          Value<String?> link = const Value.absent(),
          Value<String?> image = const Value.absent()}) =>
      ArticlesEntityData(
        id: id ?? this.id,
        title: title ?? this.title,
        summarize: summarize ?? this.summarize,
        content: content ?? this.content,
        tag: tag.present ? tag.value : this.tag,
        author: author.present ? author.value : this.author,
        link: link.present ? link.value : this.link,
        image: image.present ? image.value : this.image,
      );
  @override
  String toString() {
    return (StringBuffer('ArticlesEntityData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('summarize: $summarize, ')
          ..write('content: $content, ')
          ..write('tag: $tag, ')
          ..write('author: $author, ')
          ..write('link: $link, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, summarize, content, tag, author, link, image);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticlesEntityData &&
          other.id == this.id &&
          other.title == this.title &&
          other.summarize == this.summarize &&
          other.content == this.content &&
          other.tag == this.tag &&
          other.author == this.author &&
          other.link == this.link &&
          other.image == this.image);
}

class ArticlesEntityCompanion extends UpdateCompanion<ArticlesEntityData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> summarize;
  final Value<String> content;
  final Value<String?> tag;
  final Value<String?> author;
  final Value<String?> link;
  final Value<String?> image;
  final Value<int> rowid;
  const ArticlesEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.summarize = const Value.absent(),
    this.content = const Value.absent(),
    this.tag = const Value.absent(),
    this.author = const Value.absent(),
    this.link = const Value.absent(),
    this.image = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArticlesEntityCompanion.insert({
    required String id,
    required String title,
    required String summarize,
    required String content,
    this.tag = const Value.absent(),
    this.author = const Value.absent(),
    this.link = const Value.absent(),
    this.image = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        summarize = Value(summarize),
        content = Value(content);
  static Insertable<ArticlesEntityData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? summarize,
    Expression<String>? content,
    Expression<String>? tag,
    Expression<String>? author,
    Expression<String>? link,
    Expression<String>? image,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (summarize != null) 'summarize': summarize,
      if (content != null) 'content': content,
      if (tag != null) 'tag': tag,
      if (author != null) 'author': author,
      if (link != null) 'link': link,
      if (image != null) 'image': image,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArticlesEntityCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? summarize,
      Value<String>? content,
      Value<String?>? tag,
      Value<String?>? author,
      Value<String?>? link,
      Value<String?>? image,
      Value<int>? rowid}) {
    return ArticlesEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      summarize: summarize ?? this.summarize,
      content: content ?? this.content,
      tag: tag ?? this.tag,
      author: author ?? this.author,
      link: link ?? this.link,
      image: image ?? this.image,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (summarize.present) {
      map['summarize'] = Variable<String>(summarize.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('summarize: $summarize, ')
          ..write('content: $content, ')
          ..write('tag: $tag, ')
          ..write('author: $author, ')
          ..write('link: $link, ')
          ..write('image: $image, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BabyInforFactEntityTable extends BabyInforFactEntity
    with TableInfo<$BabyInforFactEntityTable, BabyInforFactEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BabyInforFactEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weekMeta = const VerificationMeta('week');
  @override
  late final GeneratedColumn<int> week = GeneratedColumn<int>(
      'week', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<Uint8List> image = GeneratedColumn<Uint8List>(
      'image', aliasedName, true,
      type: DriftSqlType.blob, requiredDuringInsert: false);
  static const VerificationMeta _yourBabyMeta =
      const VerificationMeta('yourBaby');
  @override
  late final GeneratedColumn<String> yourBaby = GeneratedColumn<String>(
      'your_baby', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _yourBodyMeta =
      const VerificationMeta('yourBody');
  @override
  late final GeneratedColumn<String> yourBody = GeneratedColumn<String>(
      'your_body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thingsToRememberMeta =
      const VerificationMeta('thingsToRemember');
  @override
  late final GeneratedColumn<String> thingsToRemember = GeneratedColumn<String>(
      'things_to_remember', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _factMeta = const VerificationMeta('fact');
  @override
  late final GeneratedColumn<String> fact = GeneratedColumn<String>(
      'fact', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        week,
        weight,
        height,
        image,
        yourBaby,
        yourBody,
        thingsToRemember,
        fact
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'baby_infor_fact_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<BabyInforFactEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('week')) {
      context.handle(
          _weekMeta, week.isAcceptableOrUnknown(data['week']!, _weekMeta));
    } else if (isInserting) {
      context.missing(_weekMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('your_baby')) {
      context.handle(_yourBabyMeta,
          yourBaby.isAcceptableOrUnknown(data['your_baby']!, _yourBabyMeta));
    } else if (isInserting) {
      context.missing(_yourBabyMeta);
    }
    if (data.containsKey('your_body')) {
      context.handle(_yourBodyMeta,
          yourBody.isAcceptableOrUnknown(data['your_body']!, _yourBodyMeta));
    } else if (isInserting) {
      context.missing(_yourBodyMeta);
    }
    if (data.containsKey('things_to_remember')) {
      context.handle(
          _thingsToRememberMeta,
          thingsToRemember.isAcceptableOrUnknown(
              data['things_to_remember']!, _thingsToRememberMeta));
    } else if (isInserting) {
      context.missing(_thingsToRememberMeta);
    }
    if (data.containsKey('fact')) {
      context.handle(
          _factMeta, fact.isAcceptableOrUnknown(data['fact']!, _factMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, week};
  @override
  BabyInforFactEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BabyInforFactEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      week: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}week'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}image']),
      yourBaby: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}your_baby'])!,
      yourBody: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}your_body'])!,
      thingsToRemember: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}things_to_remember'])!,
      fact: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fact']),
    );
  }

  @override
  $BabyInforFactEntityTable createAlias(String alias) {
    return $BabyInforFactEntityTable(attachedDatabase, alias);
  }
}

class BabyInforFactEntityData extends DataClass
    implements Insertable<BabyInforFactEntityData> {
  final String id;
  final int week;
  final double? weight;
  final double? height;
  final Uint8List? image;
  final String yourBaby;
  final String yourBody;
  final String thingsToRemember;
  final String? fact;
  const BabyInforFactEntityData(
      {required this.id,
      required this.week,
      this.weight,
      this.height,
      this.image,
      required this.yourBaby,
      required this.yourBody,
      required this.thingsToRemember,
      this.fact});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['week'] = Variable<int>(week);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<Uint8List>(image);
    }
    map['your_baby'] = Variable<String>(yourBaby);
    map['your_body'] = Variable<String>(yourBody);
    map['things_to_remember'] = Variable<String>(thingsToRemember);
    if (!nullToAbsent || fact != null) {
      map['fact'] = Variable<String>(fact);
    }
    return map;
  }

  BabyInforFactEntityCompanion toCompanion(bool nullToAbsent) {
    return BabyInforFactEntityCompanion(
      id: Value(id),
      week: Value(week),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      yourBaby: Value(yourBaby),
      yourBody: Value(yourBody),
      thingsToRemember: Value(thingsToRemember),
      fact: fact == null && nullToAbsent ? const Value.absent() : Value(fact),
    );
  }

  factory BabyInforFactEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BabyInforFactEntityData(
      id: serializer.fromJson<String>(json['id']),
      week: serializer.fromJson<int>(json['week']),
      weight: serializer.fromJson<double?>(json['weight']),
      height: serializer.fromJson<double?>(json['height']),
      image: serializer.fromJson<Uint8List?>(json['image']),
      yourBaby: serializer.fromJson<String>(json['yourBaby']),
      yourBody: serializer.fromJson<String>(json['yourBody']),
      thingsToRemember: serializer.fromJson<String>(json['thingsToRemember']),
      fact: serializer.fromJson<String?>(json['fact']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'week': serializer.toJson<int>(week),
      'weight': serializer.toJson<double?>(weight),
      'height': serializer.toJson<double?>(height),
      'image': serializer.toJson<Uint8List?>(image),
      'yourBaby': serializer.toJson<String>(yourBaby),
      'yourBody': serializer.toJson<String>(yourBody),
      'thingsToRemember': serializer.toJson<String>(thingsToRemember),
      'fact': serializer.toJson<String?>(fact),
    };
  }

  BabyInforFactEntityData copyWith(
          {String? id,
          int? week,
          Value<double?> weight = const Value.absent(),
          Value<double?> height = const Value.absent(),
          Value<Uint8List?> image = const Value.absent(),
          String? yourBaby,
          String? yourBody,
          String? thingsToRemember,
          Value<String?> fact = const Value.absent()}) =>
      BabyInforFactEntityData(
        id: id ?? this.id,
        week: week ?? this.week,
        weight: weight.present ? weight.value : this.weight,
        height: height.present ? height.value : this.height,
        image: image.present ? image.value : this.image,
        yourBaby: yourBaby ?? this.yourBaby,
        yourBody: yourBody ?? this.yourBody,
        thingsToRemember: thingsToRemember ?? this.thingsToRemember,
        fact: fact.present ? fact.value : this.fact,
      );
  @override
  String toString() {
    return (StringBuffer('BabyInforFactEntityData(')
          ..write('id: $id, ')
          ..write('week: $week, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('image: $image, ')
          ..write('yourBaby: $yourBaby, ')
          ..write('yourBody: $yourBody, ')
          ..write('thingsToRemember: $thingsToRemember, ')
          ..write('fact: $fact')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      week,
      weight,
      height,
      $driftBlobEquality.hash(image),
      yourBaby,
      yourBody,
      thingsToRemember,
      fact);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BabyInforFactEntityData &&
          other.id == this.id &&
          other.week == this.week &&
          other.weight == this.weight &&
          other.height == this.height &&
          $driftBlobEquality.equals(other.image, this.image) &&
          other.yourBaby == this.yourBaby &&
          other.yourBody == this.yourBody &&
          other.thingsToRemember == this.thingsToRemember &&
          other.fact == this.fact);
}

class BabyInforFactEntityCompanion
    extends UpdateCompanion<BabyInforFactEntityData> {
  final Value<String> id;
  final Value<int> week;
  final Value<double?> weight;
  final Value<double?> height;
  final Value<Uint8List?> image;
  final Value<String> yourBaby;
  final Value<String> yourBody;
  final Value<String> thingsToRemember;
  final Value<String?> fact;
  final Value<int> rowid;
  const BabyInforFactEntityCompanion({
    this.id = const Value.absent(),
    this.week = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.image = const Value.absent(),
    this.yourBaby = const Value.absent(),
    this.yourBody = const Value.absent(),
    this.thingsToRemember = const Value.absent(),
    this.fact = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BabyInforFactEntityCompanion.insert({
    required String id,
    required int week,
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.image = const Value.absent(),
    required String yourBaby,
    required String yourBody,
    required String thingsToRemember,
    this.fact = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        week = Value(week),
        yourBaby = Value(yourBaby),
        yourBody = Value(yourBody),
        thingsToRemember = Value(thingsToRemember);
  static Insertable<BabyInforFactEntityData> custom({
    Expression<String>? id,
    Expression<int>? week,
    Expression<double>? weight,
    Expression<double>? height,
    Expression<Uint8List>? image,
    Expression<String>? yourBaby,
    Expression<String>? yourBody,
    Expression<String>? thingsToRemember,
    Expression<String>? fact,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (week != null) 'week': week,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (image != null) 'image': image,
      if (yourBaby != null) 'your_baby': yourBaby,
      if (yourBody != null) 'your_body': yourBody,
      if (thingsToRemember != null) 'things_to_remember': thingsToRemember,
      if (fact != null) 'fact': fact,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BabyInforFactEntityCompanion copyWith(
      {Value<String>? id,
      Value<int>? week,
      Value<double?>? weight,
      Value<double?>? height,
      Value<Uint8List?>? image,
      Value<String>? yourBaby,
      Value<String>? yourBody,
      Value<String>? thingsToRemember,
      Value<String?>? fact,
      Value<int>? rowid}) {
    return BabyInforFactEntityCompanion(
      id: id ?? this.id,
      week: week ?? this.week,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      image: image ?? this.image,
      yourBaby: yourBaby ?? this.yourBaby,
      yourBody: yourBody ?? this.yourBody,
      thingsToRemember: thingsToRemember ?? this.thingsToRemember,
      fact: fact ?? this.fact,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (week.present) {
      map['week'] = Variable<int>(week.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (image.present) {
      map['image'] = Variable<Uint8List>(image.value);
    }
    if (yourBaby.present) {
      map['your_baby'] = Variable<String>(yourBaby.value);
    }
    if (yourBody.present) {
      map['your_body'] = Variable<String>(yourBody.value);
    }
    if (thingsToRemember.present) {
      map['things_to_remember'] = Variable<String>(thingsToRemember.value);
    }
    if (fact.present) {
      map['fact'] = Variable<String>(fact.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BabyInforFactEntityCompanion(')
          ..write('id: $id, ')
          ..write('week: $week, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('image: $image, ')
          ..write('yourBaby: $yourBaby, ')
          ..write('yourBody: $yourBody, ')
          ..write('thingsToRemember: $thingsToRemember, ')
          ..write('fact: $fact, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseApp extends GeneratedDatabase {
  _$DatabaseApp(QueryExecutor e) : super(e);
  late final $BabyInforEntityTable babyInforEntity =
      $BabyInforEntityTable(this);
  late final $NotesEntityTable notesEntity = $NotesEntityTable(this);
  late final $ArticlesEntityTable articlesEntity = $ArticlesEntityTable(this);
  late final $BabyInforFactEntityTable babyInforFactEntity =
      $BabyInforFactEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [babyInforEntity, notesEntity, articlesEntity, babyInforFactEntity];
}
