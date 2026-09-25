// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VehicleEntriesTable extends VehicleEntries
    with TableInfo<$VehicleEntriesTable, VehicleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _makeMeta = const VerificationMeta('make');
  @override
  late final GeneratedColumn<String> make = GeneratedColumn<String>(
    'make',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licensePlateMeta = const VerificationMeta(
    'licensePlate',
  );
  @override
  late final GeneratedColumn<String> licensePlate = GeneratedColumn<String>(
    'license_plate',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageMeta = const VerificationMeta(
    'mileage',
  );
  @override
  late final GeneratedColumn<int> mileage = GeneratedColumn<int>(
    'mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextInspectionMeta = const VerificationMeta(
    'nextInspection',
  );
  @override
  late final GeneratedColumn<DateTime> nextInspection =
      GeneratedColumn<DateTime>(
        'next_inspection',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _associatedPersonMeta = const VerificationMeta(
    'associatedPerson',
  );
  @override
  late final GeneratedColumn<String> associatedPerson = GeneratedColumn<String>(
    'associated_person',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vehicleTypeMeta = const VerificationMeta(
    'vehicleType',
  );
  @override
  late final GeneratedColumn<String> vehicleType = GeneratedColumn<String>(
    'vehicle_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('car'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    make,
    model,
    year,
    licensePlate,
    mileage,
    nextInspection,
    color,
    associatedPerson,
    vehicleType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehicleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('make')) {
      context.handle(
        _makeMeta,
        make.isAcceptableOrUnknown(data['make']!, _makeMeta),
      );
    } else if (isInserting) {
      context.missing(_makeMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('license_plate')) {
      context.handle(
        _licensePlateMeta,
        licensePlate.isAcceptableOrUnknown(
          data['license_plate']!,
          _licensePlateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licensePlateMeta);
    }
    if (data.containsKey('mileage')) {
      context.handle(
        _mileageMeta,
        mileage.isAcceptableOrUnknown(data['mileage']!, _mileageMeta),
      );
    } else if (isInserting) {
      context.missing(_mileageMeta);
    }
    if (data.containsKey('next_inspection')) {
      context.handle(
        _nextInspectionMeta,
        nextInspection.isAcceptableOrUnknown(
          data['next_inspection']!,
          _nextInspectionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextInspectionMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('associated_person')) {
      context.handle(
        _associatedPersonMeta,
        associatedPerson.isAcceptableOrUnknown(
          data['associated_person']!,
          _associatedPersonMeta,
        ),
      );
    }
    if (data.containsKey('vehicle_type')) {
      context.handle(
        _vehicleTypeMeta,
        vehicleType.isAcceptableOrUnknown(
          data['vehicle_type']!,
          _vehicleTypeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      make: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}make'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      licensePlate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_plate'],
      )!,
      mileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mileage'],
      )!,
      nextInspection: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_inspection'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      associatedPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}associated_person'],
      ),
      vehicleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_type'],
      )!,
    );
  }

  @override
  $VehicleEntriesTable createAlias(String alias) {
    return $VehicleEntriesTable(attachedDatabase, alias);
  }
}

class VehicleRow extends DataClass implements Insertable<VehicleRow> {
  final String id;
  final String make;
  final String model;
  final int year;
  final String licensePlate;
  final int mileage;
  final DateTime nextInspection;
  final int color;
  final String? associatedPerson;
  final String vehicleType;
  const VehicleRow({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.licensePlate,
    required this.mileage,
    required this.nextInspection,
    required this.color,
    this.associatedPerson,
    required this.vehicleType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['make'] = Variable<String>(make);
    map['model'] = Variable<String>(model);
    map['year'] = Variable<int>(year);
    map['license_plate'] = Variable<String>(licensePlate);
    map['mileage'] = Variable<int>(mileage);
    map['next_inspection'] = Variable<DateTime>(nextInspection);
    map['color'] = Variable<int>(color);
    if (!nullToAbsent || associatedPerson != null) {
      map['associated_person'] = Variable<String>(associatedPerson);
    }
    map['vehicle_type'] = Variable<String>(vehicleType);
    return map;
  }

  VehicleEntriesCompanion toCompanion(bool nullToAbsent) {
    return VehicleEntriesCompanion(
      id: Value(id),
      make: Value(make),
      model: Value(model),
      year: Value(year),
      licensePlate: Value(licensePlate),
      mileage: Value(mileage),
      nextInspection: Value(nextInspection),
      color: Value(color),
      associatedPerson: associatedPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(associatedPerson),
      vehicleType: Value(vehicleType),
    );
  }

  factory VehicleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleRow(
      id: serializer.fromJson<String>(json['id']),
      make: serializer.fromJson<String>(json['make']),
      model: serializer.fromJson<String>(json['model']),
      year: serializer.fromJson<int>(json['year']),
      licensePlate: serializer.fromJson<String>(json['licensePlate']),
      mileage: serializer.fromJson<int>(json['mileage']),
      nextInspection: serializer.fromJson<DateTime>(json['nextInspection']),
      color: serializer.fromJson<int>(json['color']),
      associatedPerson: serializer.fromJson<String?>(json['associatedPerson']),
      vehicleType: serializer.fromJson<String>(json['vehicleType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'make': serializer.toJson<String>(make),
      'model': serializer.toJson<String>(model),
      'year': serializer.toJson<int>(year),
      'licensePlate': serializer.toJson<String>(licensePlate),
      'mileage': serializer.toJson<int>(mileage),
      'nextInspection': serializer.toJson<DateTime>(nextInspection),
      'color': serializer.toJson<int>(color),
      'associatedPerson': serializer.toJson<String?>(associatedPerson),
      'vehicleType': serializer.toJson<String>(vehicleType),
    };
  }

  VehicleRow copyWith({
    String? id,
    String? make,
    String? model,
    int? year,
    String? licensePlate,
    int? mileage,
    DateTime? nextInspection,
    int? color,
    Value<String?> associatedPerson = const Value.absent(),
    String? vehicleType,
  }) => VehicleRow(
    id: id ?? this.id,
    make: make ?? this.make,
    model: model ?? this.model,
    year: year ?? this.year,
    licensePlate: licensePlate ?? this.licensePlate,
    mileage: mileage ?? this.mileage,
    nextInspection: nextInspection ?? this.nextInspection,
    color: color ?? this.color,
    associatedPerson: associatedPerson.present
        ? associatedPerson.value
        : this.associatedPerson,
    vehicleType: vehicleType ?? this.vehicleType,
  );
  VehicleRow copyWithCompanion(VehicleEntriesCompanion data) {
    return VehicleRow(
      id: data.id.present ? data.id.value : this.id,
      make: data.make.present ? data.make.value : this.make,
      model: data.model.present ? data.model.value : this.model,
      year: data.year.present ? data.year.value : this.year,
      licensePlate: data.licensePlate.present
          ? data.licensePlate.value
          : this.licensePlate,
      mileage: data.mileage.present ? data.mileage.value : this.mileage,
      nextInspection: data.nextInspection.present
          ? data.nextInspection.value
          : this.nextInspection,
      color: data.color.present ? data.color.value : this.color,
      associatedPerson: data.associatedPerson.present
          ? data.associatedPerson.value
          : this.associatedPerson,
      vehicleType: data.vehicleType.present
          ? data.vehicleType.value
          : this.vehicleType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleRow(')
          ..write('id: $id, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('licensePlate: $licensePlate, ')
          ..write('mileage: $mileage, ')
          ..write('nextInspection: $nextInspection, ')
          ..write('color: $color, ')
          ..write('associatedPerson: $associatedPerson, ')
          ..write('vehicleType: $vehicleType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    make,
    model,
    year,
    licensePlate,
    mileage,
    nextInspection,
    color,
    associatedPerson,
    vehicleType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleRow &&
          other.id == this.id &&
          other.make == this.make &&
          other.model == this.model &&
          other.year == this.year &&
          other.licensePlate == this.licensePlate &&
          other.mileage == this.mileage &&
          other.nextInspection == this.nextInspection &&
          other.color == this.color &&
          other.associatedPerson == this.associatedPerson &&
          other.vehicleType == this.vehicleType);
}

class VehicleEntriesCompanion extends UpdateCompanion<VehicleRow> {
  final Value<String> id;
  final Value<String> make;
  final Value<String> model;
  final Value<int> year;
  final Value<String> licensePlate;
  final Value<int> mileage;
  final Value<DateTime> nextInspection;
  final Value<int> color;
  final Value<String?> associatedPerson;
  final Value<String> vehicleType;
  final Value<int> rowid;
  const VehicleEntriesCompanion({
    this.id = const Value.absent(),
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.licensePlate = const Value.absent(),
    this.mileage = const Value.absent(),
    this.nextInspection = const Value.absent(),
    this.color = const Value.absent(),
    this.associatedPerson = const Value.absent(),
    this.vehicleType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehicleEntriesCompanion.insert({
    required String id,
    required String make,
    required String model,
    required int year,
    required String licensePlate,
    required int mileage,
    required DateTime nextInspection,
    required int color,
    this.associatedPerson = const Value.absent(),
    this.vehicleType = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       make = Value(make),
       model = Value(model),
       year = Value(year),
       licensePlate = Value(licensePlate),
       mileage = Value(mileage),
       nextInspection = Value(nextInspection),
       color = Value(color);
  static Insertable<VehicleRow> custom({
    Expression<String>? id,
    Expression<String>? make,
    Expression<String>? model,
    Expression<int>? year,
    Expression<String>? licensePlate,
    Expression<int>? mileage,
    Expression<DateTime>? nextInspection,
    Expression<int>? color,
    Expression<String>? associatedPerson,
    Expression<String>? vehicleType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (licensePlate != null) 'license_plate': licensePlate,
      if (mileage != null) 'mileage': mileage,
      if (nextInspection != null) 'next_inspection': nextInspection,
      if (color != null) 'color': color,
      if (associatedPerson != null) 'associated_person': associatedPerson,
      if (vehicleType != null) 'vehicle_type': vehicleType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehicleEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? make,
    Value<String>? model,
    Value<int>? year,
    Value<String>? licensePlate,
    Value<int>? mileage,
    Value<DateTime>? nextInspection,
    Value<int>? color,
    Value<String?>? associatedPerson,
    Value<String>? vehicleType,
    Value<int>? rowid,
  }) {
    return VehicleEntriesCompanion(
      id: id ?? this.id,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      licensePlate: licensePlate ?? this.licensePlate,
      mileage: mileage ?? this.mileage,
      nextInspection: nextInspection ?? this.nextInspection,
      color: color ?? this.color,
      associatedPerson: associatedPerson ?? this.associatedPerson,
      vehicleType: vehicleType ?? this.vehicleType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (make.present) {
      map['make'] = Variable<String>(make.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (licensePlate.present) {
      map['license_plate'] = Variable<String>(licensePlate.value);
    }
    if (mileage.present) {
      map['mileage'] = Variable<int>(mileage.value);
    }
    if (nextInspection.present) {
      map['next_inspection'] = Variable<DateTime>(nextInspection.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (associatedPerson.present) {
      map['associated_person'] = Variable<String>(associatedPerson.value);
    }
    if (vehicleType.present) {
      map['vehicle_type'] = Variable<String>(vehicleType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleEntriesCompanion(')
          ..write('id: $id, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('licensePlate: $licensePlate, ')
          ..write('mileage: $mileage, ')
          ..write('nextInspection: $nextInspection, ')
          ..write('color: $color, ')
          ..write('associatedPerson: $associatedPerson, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ObligationEntriesTable extends ObligationEntries
    with TableInfo<$ObligationEntriesTable, ObligationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObligationEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasExactDayMeta = const VerificationMeta(
    'hasExactDay',
  );
  @override
  late final GeneratedColumn<bool> hasExactDay = GeneratedColumn<bool>(
    'has_exact_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_exact_day" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remindMonthBeforeMeta = const VerificationMeta(
    'remindMonthBefore',
  );
  @override
  late final GeneratedColumn<bool> remindMonthBefore = GeneratedColumn<bool>(
    'remind_month_before',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("remind_month_before" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _remindDueMonthMeta = const VerificationMeta(
    'remindDueMonth',
  );
  @override
  late final GeneratedColumn<bool> remindDueMonth = GeneratedColumn<bool>(
    'remind_due_month',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("remind_due_month" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    type,
    frequency,
    nextDueDate,
    hasExactDay,
    provider,
    notes,
    remindMonthBefore,
    remindDueMonth,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'obligation_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ObligationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextDueDateMeta);
    }
    if (data.containsKey('has_exact_day')) {
      context.handle(
        _hasExactDayMeta,
        hasExactDay.isAcceptableOrUnknown(
          data['has_exact_day']!,
          _hasExactDayMeta,
        ),
      );
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('remind_month_before')) {
      context.handle(
        _remindMonthBeforeMeta,
        remindMonthBefore.isAcceptableOrUnknown(
          data['remind_month_before']!,
          _remindMonthBeforeMeta,
        ),
      );
    }
    if (data.containsKey('remind_due_month')) {
      context.handle(
        _remindDueMonthMeta,
        remindDueMonth.isAcceptableOrUnknown(
          data['remind_due_month']!,
          _remindDueMonthMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ObligationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ObligationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      )!,
      hasExactDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_exact_day'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      remindMonthBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}remind_month_before'],
      )!,
      remindDueMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}remind_due_month'],
      )!,
    );
  }

  @override
  $ObligationEntriesTable createAlias(String alias) {
    return $ObligationEntriesTable(attachedDatabase, alias);
  }
}

class ObligationRow extends DataClass implements Insertable<ObligationRow> {
  final String id;
  final String vehicleId;
  final String type;
  final String frequency;
  final DateTime nextDueDate;
  final bool hasExactDay;
  final String? provider;
  final String? notes;
  final bool remindMonthBefore;
  final bool remindDueMonth;
  const ObligationRow({
    required this.id,
    required this.vehicleId,
    required this.type,
    required this.frequency,
    required this.nextDueDate,
    required this.hasExactDay,
    this.provider,
    this.notes,
    required this.remindMonthBefore,
    required this.remindDueMonth,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['type'] = Variable<String>(type);
    map['frequency'] = Variable<String>(frequency);
    map['next_due_date'] = Variable<DateTime>(nextDueDate);
    map['has_exact_day'] = Variable<bool>(hasExactDay);
    if (!nullToAbsent || provider != null) {
      map['provider'] = Variable<String>(provider);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['remind_month_before'] = Variable<bool>(remindMonthBefore);
    map['remind_due_month'] = Variable<bool>(remindDueMonth);
    return map;
  }

  ObligationEntriesCompanion toCompanion(bool nullToAbsent) {
    return ObligationEntriesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      type: Value(type),
      frequency: Value(frequency),
      nextDueDate: Value(nextDueDate),
      hasExactDay: Value(hasExactDay),
      provider: provider == null && nullToAbsent
          ? const Value.absent()
          : Value(provider),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      remindMonthBefore: Value(remindMonthBefore),
      remindDueMonth: Value(remindDueMonth),
    );
  }

  factory ObligationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ObligationRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      type: serializer.fromJson<String>(json['type']),
      frequency: serializer.fromJson<String>(json['frequency']),
      nextDueDate: serializer.fromJson<DateTime>(json['nextDueDate']),
      hasExactDay: serializer.fromJson<bool>(json['hasExactDay']),
      provider: serializer.fromJson<String?>(json['provider']),
      notes: serializer.fromJson<String?>(json['notes']),
      remindMonthBefore: serializer.fromJson<bool>(json['remindMonthBefore']),
      remindDueMonth: serializer.fromJson<bool>(json['remindDueMonth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'type': serializer.toJson<String>(type),
      'frequency': serializer.toJson<String>(frequency),
      'nextDueDate': serializer.toJson<DateTime>(nextDueDate),
      'hasExactDay': serializer.toJson<bool>(hasExactDay),
      'provider': serializer.toJson<String?>(provider),
      'notes': serializer.toJson<String?>(notes),
      'remindMonthBefore': serializer.toJson<bool>(remindMonthBefore),
      'remindDueMonth': serializer.toJson<bool>(remindDueMonth),
    };
  }

  ObligationRow copyWith({
    String? id,
    String? vehicleId,
    String? type,
    String? frequency,
    DateTime? nextDueDate,
    bool? hasExactDay,
    Value<String?> provider = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? remindMonthBefore,
    bool? remindDueMonth,
  }) => ObligationRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    type: type ?? this.type,
    frequency: frequency ?? this.frequency,
    nextDueDate: nextDueDate ?? this.nextDueDate,
    hasExactDay: hasExactDay ?? this.hasExactDay,
    provider: provider.present ? provider.value : this.provider,
    notes: notes.present ? notes.value : this.notes,
    remindMonthBefore: remindMonthBefore ?? this.remindMonthBefore,
    remindDueMonth: remindDueMonth ?? this.remindDueMonth,
  );
  ObligationRow copyWithCompanion(ObligationEntriesCompanion data) {
    return ObligationRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      type: data.type.present ? data.type.value : this.type,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
      hasExactDay: data.hasExactDay.present
          ? data.hasExactDay.value
          : this.hasExactDay,
      provider: data.provider.present ? data.provider.value : this.provider,
      notes: data.notes.present ? data.notes.value : this.notes,
      remindMonthBefore: data.remindMonthBefore.present
          ? data.remindMonthBefore.value
          : this.remindMonthBefore,
      remindDueMonth: data.remindDueMonth.present
          ? data.remindDueMonth.value
          : this.remindDueMonth,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ObligationRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('type: $type, ')
          ..write('frequency: $frequency, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('hasExactDay: $hasExactDay, ')
          ..write('provider: $provider, ')
          ..write('notes: $notes, ')
          ..write('remindMonthBefore: $remindMonthBefore, ')
          ..write('remindDueMonth: $remindDueMonth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    type,
    frequency,
    nextDueDate,
    hasExactDay,
    provider,
    notes,
    remindMonthBefore,
    remindDueMonth,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ObligationRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.type == this.type &&
          other.frequency == this.frequency &&
          other.nextDueDate == this.nextDueDate &&
          other.hasExactDay == this.hasExactDay &&
          other.provider == this.provider &&
          other.notes == this.notes &&
          other.remindMonthBefore == this.remindMonthBefore &&
          other.remindDueMonth == this.remindDueMonth);
}

class ObligationEntriesCompanion extends UpdateCompanion<ObligationRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> type;
  final Value<String> frequency;
  final Value<DateTime> nextDueDate;
  final Value<bool> hasExactDay;
  final Value<String?> provider;
  final Value<String?> notes;
  final Value<bool> remindMonthBefore;
  final Value<bool> remindDueMonth;
  final Value<int> rowid;
  const ObligationEntriesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.type = const Value.absent(),
    this.frequency = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.hasExactDay = const Value.absent(),
    this.provider = const Value.absent(),
    this.notes = const Value.absent(),
    this.remindMonthBefore = const Value.absent(),
    this.remindDueMonth = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ObligationEntriesCompanion.insert({
    required String id,
    required String vehicleId,
    required String type,
    required String frequency,
    required DateTime nextDueDate,
    this.hasExactDay = const Value.absent(),
    this.provider = const Value.absent(),
    this.notes = const Value.absent(),
    this.remindMonthBefore = const Value.absent(),
    this.remindDueMonth = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       type = Value(type),
       frequency = Value(frequency),
       nextDueDate = Value(nextDueDate);
  static Insertable<ObligationRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? type,
    Expression<String>? frequency,
    Expression<DateTime>? nextDueDate,
    Expression<bool>? hasExactDay,
    Expression<String>? provider,
    Expression<String>? notes,
    Expression<bool>? remindMonthBefore,
    Expression<bool>? remindDueMonth,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (type != null) 'type': type,
      if (frequency != null) 'frequency': frequency,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (hasExactDay != null) 'has_exact_day': hasExactDay,
      if (provider != null) 'provider': provider,
      if (notes != null) 'notes': notes,
      if (remindMonthBefore != null) 'remind_month_before': remindMonthBefore,
      if (remindDueMonth != null) 'remind_due_month': remindDueMonth,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ObligationEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String>? type,
    Value<String>? frequency,
    Value<DateTime>? nextDueDate,
    Value<bool>? hasExactDay,
    Value<String?>? provider,
    Value<String?>? notes,
    Value<bool>? remindMonthBefore,
    Value<bool>? remindDueMonth,
    Value<int>? rowid,
  }) {
    return ObligationEntriesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      hasExactDay: hasExactDay ?? this.hasExactDay,
      provider: provider ?? this.provider,
      notes: notes ?? this.notes,
      remindMonthBefore: remindMonthBefore ?? this.remindMonthBefore,
      remindDueMonth: remindDueMonth ?? this.remindDueMonth,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (hasExactDay.present) {
      map['has_exact_day'] = Variable<bool>(hasExactDay.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (remindMonthBefore.present) {
      map['remind_month_before'] = Variable<bool>(remindMonthBefore.value);
    }
    if (remindDueMonth.present) {
      map['remind_due_month'] = Variable<bool>(remindDueMonth.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObligationEntriesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('type: $type, ')
          ..write('frequency: $frequency, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('hasExactDay: $hasExactDay, ')
          ..write('provider: $provider, ')
          ..write('notes: $notes, ')
          ..write('remindMonthBefore: $remindMonthBefore, ')
          ..write('remindDueMonth: $remindDueMonth, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventEntriesTable extends EventEntries
    with TableInfo<$EventEntriesTable, EventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtitleMeta = const VerificationMeta(
    'subtitle',
  );
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
    'subtitle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _obligationIdMeta = const VerificationMeta(
    'obligationId',
  );
  @override
  late final GeneratedColumn<String> obligationId = GeneratedColumn<String>(
    'obligation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    title,
    subtitle,
    date,
    type,
    amount,
    notes,
    obligationId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(
        _subtitleMeta,
        subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta),
      );
    } else if (isInserting) {
      context.missing(_subtitleMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('obligation_id')) {
      context.handle(
        _obligationIdMeta,
        obligationId.isAcceptableOrUnknown(
          data['obligation_id']!,
          _obligationIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      subtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      obligationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}obligation_id'],
      ),
    );
  }

  @override
  $EventEntriesTable createAlias(String alias) {
    return $EventEntriesTable(attachedDatabase, alias);
  }
}

class EventRow extends DataClass implements Insertable<EventRow> {
  final String id;
  final String vehicleId;
  final String title;
  final String subtitle;
  final DateTime date;
  final String type;
  final double? amount;
  final String? notes;
  final String? obligationId;
  const EventRow({
    required this.id,
    required this.vehicleId,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.type,
    this.amount,
    this.notes,
    this.obligationId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['title'] = Variable<String>(title);
    map['subtitle'] = Variable<String>(subtitle);
    map['date'] = Variable<DateTime>(date);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || obligationId != null) {
      map['obligation_id'] = Variable<String>(obligationId);
    }
    return map;
  }

  EventEntriesCompanion toCompanion(bool nullToAbsent) {
    return EventEntriesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      title: Value(title),
      subtitle: Value(subtitle),
      date: Value(date),
      type: Value(type),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      obligationId: obligationId == null && nullToAbsent
          ? const Value.absent()
          : Value(obligationId),
    );
  }

  factory EventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      title: serializer.fromJson<String>(json['title']),
      subtitle: serializer.fromJson<String>(json['subtitle']),
      date: serializer.fromJson<DateTime>(json['date']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double?>(json['amount']),
      notes: serializer.fromJson<String?>(json['notes']),
      obligationId: serializer.fromJson<String?>(json['obligationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'title': serializer.toJson<String>(title),
      'subtitle': serializer.toJson<String>(subtitle),
      'date': serializer.toJson<DateTime>(date),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double?>(amount),
      'notes': serializer.toJson<String?>(notes),
      'obligationId': serializer.toJson<String?>(obligationId),
    };
  }

  EventRow copyWith({
    String? id,
    String? vehicleId,
    String? title,
    String? subtitle,
    DateTime? date,
    String? type,
    Value<double?> amount = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> obligationId = const Value.absent(),
  }) => EventRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    title: title ?? this.title,
    subtitle: subtitle ?? this.subtitle,
    date: date ?? this.date,
    type: type ?? this.type,
    amount: amount.present ? amount.value : this.amount,
    notes: notes.present ? notes.value : this.notes,
    obligationId: obligationId.present ? obligationId.value : this.obligationId,
  );
  EventRow copyWithCompanion(EventEntriesCompanion data) {
    return EventRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      title: data.title.present ? data.title.value : this.title,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      notes: data.notes.present ? data.notes.value : this.notes,
      obligationId: data.obligationId.present
          ? data.obligationId.value
          : this.obligationId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes, ')
          ..write('obligationId: $obligationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    title,
    subtitle,
    date,
    type,
    amount,
    notes,
    obligationId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.date == this.date &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.notes == this.notes &&
          other.obligationId == this.obligationId);
}

class EventEntriesCompanion extends UpdateCompanion<EventRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> title;
  final Value<String> subtitle;
  final Value<DateTime> date;
  final Value<String> type;
  final Value<double?> amount;
  final Value<String?> notes;
  final Value<String?> obligationId;
  final Value<int> rowid;
  const EventEntriesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.notes = const Value.absent(),
    this.obligationId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventEntriesCompanion.insert({
    required String id,
    required String vehicleId,
    required String title,
    required String subtitle,
    required DateTime date,
    required String type,
    this.amount = const Value.absent(),
    this.notes = const Value.absent(),
    this.obligationId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       title = Value(title),
       subtitle = Value(subtitle),
       date = Value(date),
       type = Value(type);
  static Insertable<EventRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<DateTime>? date,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<String>? notes,
    Expression<String>? obligationId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (notes != null) 'notes': notes,
      if (obligationId != null) 'obligation_id': obligationId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String>? title,
    Value<String>? subtitle,
    Value<DateTime>? date,
    Value<String>? type,
    Value<double?>? amount,
    Value<String?>? notes,
    Value<String?>? obligationId,
    Value<int>? rowid,
  }) {
    return EventEntriesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      obligationId: obligationId ?? this.obligationId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (obligationId.present) {
      map['obligation_id'] = Variable<String>(obligationId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventEntriesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes, ')
          ..write('obligationId: $obligationId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VehicleEntriesTable vehicleEntries = $VehicleEntriesTable(this);
  late final $ObligationEntriesTable obligationEntries =
      $ObligationEntriesTable(this);
  late final $EventEntriesTable eventEntries = $EventEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    vehicleEntries,
    obligationEntries,
    eventEntries,
  ];
}

typedef $$VehicleEntriesTableCreateCompanionBuilder =
    VehicleEntriesCompanion Function({
      required String id,
      required String make,
      required String model,
      required int year,
      required String licensePlate,
      required int mileage,
      required DateTime nextInspection,
      required int color,
      Value<String?> associatedPerson,
      Value<String> vehicleType,
      Value<int> rowid,
    });
typedef $$VehicleEntriesTableUpdateCompanionBuilder =
    VehicleEntriesCompanion Function({
      Value<String> id,
      Value<String> make,
      Value<String> model,
      Value<int> year,
      Value<String> licensePlate,
      Value<int> mileage,
      Value<DateTime> nextInspection,
      Value<int> color,
      Value<String?> associatedPerson,
      Value<String> vehicleType,
      Value<int> rowid,
    });

class $$VehicleEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $VehicleEntriesTable> {
  $$VehicleEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextInspection => $composableBuilder(
    column: $table.nextInspection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get associatedPerson => $composableBuilder(
    column: $table.associatedPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VehicleEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehicleEntriesTable> {
  $$VehicleEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextInspection => $composableBuilder(
    column: $table.nextInspection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get associatedPerson => $composableBuilder(
    column: $table.associatedPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehicleEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehicleEntriesTable> {
  $$VehicleEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get make =>
      $composableBuilder(column: $table.make, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mileage =>
      $composableBuilder(column: $table.mileage, builder: (column) => column);

  GeneratedColumn<DateTime> get nextInspection => $composableBuilder(
    column: $table.nextInspection,
    builder: (column) => column,
  );

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get associatedPerson => $composableBuilder(
    column: $table.associatedPerson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => column,
  );
}

class $$VehicleEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehicleEntriesTable,
          VehicleRow,
          $$VehicleEntriesTableFilterComposer,
          $$VehicleEntriesTableOrderingComposer,
          $$VehicleEntriesTableAnnotationComposer,
          $$VehicleEntriesTableCreateCompanionBuilder,
          $$VehicleEntriesTableUpdateCompanionBuilder,
          (
            VehicleRow,
            BaseReferences<_$AppDatabase, $VehicleEntriesTable, VehicleRow>,
          ),
          VehicleRow,
          PrefetchHooks Function()
        > {
  $$VehicleEntriesTableTableManager(
    _$AppDatabase db,
    $VehicleEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehicleEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehicleEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehicleEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> make = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<String> licensePlate = const Value.absent(),
                Value<int> mileage = const Value.absent(),
                Value<DateTime> nextInspection = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<String?> associatedPerson = const Value.absent(),
                Value<String> vehicleType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehicleEntriesCompanion(
                id: id,
                make: make,
                model: model,
                year: year,
                licensePlate: licensePlate,
                mileage: mileage,
                nextInspection: nextInspection,
                color: color,
                associatedPerson: associatedPerson,
                vehicleType: vehicleType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String make,
                required String model,
                required int year,
                required String licensePlate,
                required int mileage,
                required DateTime nextInspection,
                required int color,
                Value<String?> associatedPerson = const Value.absent(),
                Value<String> vehicleType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehicleEntriesCompanion.insert(
                id: id,
                make: make,
                model: model,
                year: year,
                licensePlate: licensePlate,
                mileage: mileage,
                nextInspection: nextInspection,
                color: color,
                associatedPerson: associatedPerson,
                vehicleType: vehicleType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehicleEntriesTable, VehicleRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $VehicleEntriesTable,
                    VehicleRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VehicleEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehicleEntriesTable,
      VehicleRow,
      $$VehicleEntriesTableFilterComposer,
      $$VehicleEntriesTableOrderingComposer,
      $$VehicleEntriesTableAnnotationComposer,
      $$VehicleEntriesTableCreateCompanionBuilder,
      $$VehicleEntriesTableUpdateCompanionBuilder,
      (
        VehicleRow,
        BaseReferences<_$AppDatabase, $VehicleEntriesTable, VehicleRow>,
      ),
      VehicleRow,
      PrefetchHooks Function()
    >;
typedef $$ObligationEntriesTableCreateCompanionBuilder =
    ObligationEntriesCompanion Function({
      required String id,
      required String vehicleId,
      required String type,
      required String frequency,
      required DateTime nextDueDate,
      Value<bool> hasExactDay,
      Value<String?> provider,
      Value<String?> notes,
      Value<bool> remindMonthBefore,
      Value<bool> remindDueMonth,
      Value<int> rowid,
    });
typedef $$ObligationEntriesTableUpdateCompanionBuilder =
    ObligationEntriesCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<String> type,
      Value<String> frequency,
      Value<DateTime> nextDueDate,
      Value<bool> hasExactDay,
      Value<String?> provider,
      Value<String?> notes,
      Value<bool> remindMonthBefore,
      Value<bool> remindDueMonth,
      Value<int> rowid,
    });

class $$ObligationEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ObligationEntriesTable> {
  $$ObligationEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasExactDay => $composableBuilder(
    column: $table.hasExactDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindMonthBefore => $composableBuilder(
    column: $table.remindMonthBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindDueMonth => $composableBuilder(
    column: $table.remindDueMonth,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ObligationEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ObligationEntriesTable> {
  $$ObligationEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasExactDay => $composableBuilder(
    column: $table.hasExactDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindMonthBefore => $composableBuilder(
    column: $table.remindMonthBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindDueMonth => $composableBuilder(
    column: $table.remindDueMonth,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ObligationEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ObligationEntriesTable> {
  $$ObligationEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get vehicleId =>
      $composableBuilder(column: $table.vehicleId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasExactDay => $composableBuilder(
    column: $table.hasExactDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get remindMonthBefore => $composableBuilder(
    column: $table.remindMonthBefore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindDueMonth => $composableBuilder(
    column: $table.remindDueMonth,
    builder: (column) => column,
  );
}

class $$ObligationEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ObligationEntriesTable,
          ObligationRow,
          $$ObligationEntriesTableFilterComposer,
          $$ObligationEntriesTableOrderingComposer,
          $$ObligationEntriesTableAnnotationComposer,
          $$ObligationEntriesTableCreateCompanionBuilder,
          $$ObligationEntriesTableUpdateCompanionBuilder,
          (
            ObligationRow,
            BaseReferences<
              _$AppDatabase,
              $ObligationEntriesTable,
              ObligationRow
            >,
          ),
          ObligationRow,
          PrefetchHooks Function()
        > {
  $$ObligationEntriesTableTableManager(
    _$AppDatabase db,
    $ObligationEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ObligationEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ObligationEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ObligationEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<DateTime> nextDueDate = const Value.absent(),
                Value<bool> hasExactDay = const Value.absent(),
                Value<String?> provider = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> remindMonthBefore = const Value.absent(),
                Value<bool> remindDueMonth = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObligationEntriesCompanion(
                id: id,
                vehicleId: vehicleId,
                type: type,
                frequency: frequency,
                nextDueDate: nextDueDate,
                hasExactDay: hasExactDay,
                provider: provider,
                notes: notes,
                remindMonthBefore: remindMonthBefore,
                remindDueMonth: remindDueMonth,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required String type,
                required String frequency,
                required DateTime nextDueDate,
                Value<bool> hasExactDay = const Value.absent(),
                Value<String?> provider = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> remindMonthBefore = const Value.absent(),
                Value<bool> remindDueMonth = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObligationEntriesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                type: type,
                frequency: frequency,
                nextDueDate: nextDueDate,
                hasExactDay: hasExactDay,
                provider: provider,
                notes: notes,
                remindMonthBefore: remindMonthBefore,
                remindDueMonth: remindDueMonth,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ObligationEntriesTable, ObligationRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ObligationEntriesTable,
                    ObligationRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ObligationEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ObligationEntriesTable,
      ObligationRow,
      $$ObligationEntriesTableFilterComposer,
      $$ObligationEntriesTableOrderingComposer,
      $$ObligationEntriesTableAnnotationComposer,
      $$ObligationEntriesTableCreateCompanionBuilder,
      $$ObligationEntriesTableUpdateCompanionBuilder,
      (
        ObligationRow,
        BaseReferences<_$AppDatabase, $ObligationEntriesTable, ObligationRow>,
      ),
      ObligationRow,
      PrefetchHooks Function()
    >;
typedef $$EventEntriesTableCreateCompanionBuilder =
    EventEntriesCompanion Function({
      required String id,
      required String vehicleId,
      required String title,
      required String subtitle,
      required DateTime date,
      required String type,
      Value<double?> amount,
      Value<String?> notes,
      Value<String?> obligationId,
      Value<int> rowid,
    });
typedef $$EventEntriesTableUpdateCompanionBuilder =
    EventEntriesCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<String> title,
      Value<String> subtitle,
      Value<DateTime> date,
      Value<String> type,
      Value<double?> amount,
      Value<String?> notes,
      Value<String?> obligationId,
      Value<int> rowid,
    });

class $$EventEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $EventEntriesTable> {
  $$EventEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get obligationId => $composableBuilder(
    column: $table.obligationId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $EventEntriesTable> {
  $$EventEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get obligationId => $composableBuilder(
    column: $table.obligationId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventEntriesTable> {
  $$EventEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get vehicleId =>
      $composableBuilder(column: $table.vehicleId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get obligationId => $composableBuilder(
    column: $table.obligationId,
    builder: (column) => column,
  );
}

class $$EventEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventEntriesTable,
          EventRow,
          $$EventEntriesTableFilterComposer,
          $$EventEntriesTableOrderingComposer,
          $$EventEntriesTableAnnotationComposer,
          $$EventEntriesTableCreateCompanionBuilder,
          $$EventEntriesTableUpdateCompanionBuilder,
          (
            EventRow,
            BaseReferences<_$AppDatabase, $EventEntriesTable, EventRow>,
          ),
          EventRow,
          PrefetchHooks Function()
        > {
  $$EventEntriesTableTableManager(_$AppDatabase db, $EventEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> subtitle = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> obligationId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventEntriesCompanion(
                id: id,
                vehicleId: vehicleId,
                title: title,
                subtitle: subtitle,
                date: date,
                type: type,
                amount: amount,
                notes: notes,
                obligationId: obligationId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required String title,
                required String subtitle,
                required DateTime date,
                required String type,
                Value<double?> amount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> obligationId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventEntriesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                title: title,
                subtitle: subtitle,
                date: date,
                type: type,
                amount: amount,
                notes: notes,
                obligationId: obligationId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EventEntriesTable, EventRow>(table),
                  BaseReferences<_$AppDatabase, $EventEntriesTable, EventRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventEntriesTable,
      EventRow,
      $$EventEntriesTableFilterComposer,
      $$EventEntriesTableOrderingComposer,
      $$EventEntriesTableAnnotationComposer,
      $$EventEntriesTableCreateCompanionBuilder,
      $$EventEntriesTableUpdateCompanionBuilder,
      (EventRow, BaseReferences<_$AppDatabase, $EventEntriesTable, EventRow>),
      EventRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VehicleEntriesTableTableManager get vehicleEntries =>
      $$VehicleEntriesTableTableManager(_db, _db.vehicleEntries);
  $$ObligationEntriesTableTableManager get obligationEntries =>
      $$ObligationEntriesTableTableManager(_db, _db.obligationEntries);
  $$EventEntriesTableTableManager get eventEntries =>
      $$EventEntriesTableTableManager(_db, _db.eventEntries);
}
