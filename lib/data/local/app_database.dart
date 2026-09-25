import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DataClassName('VehicleRow')
class VehicleEntries extends Table {
  TextColumn get id => text()();
  TextColumn get make => text()();
  TextColumn get model => text()();
  IntColumn get year => integer()();
  TextColumn get licensePlate => text()();
  IntColumn get mileage => integer()();
  DateTimeColumn get nextInspection => dateTime()();
  IntColumn get color => integer()();
  TextColumn get associatedPerson => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ObligationRow')
class ObligationEntries extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text()();
  TextColumn get type => text()();
  TextColumn get frequency => text()();
  DateTimeColumn get nextDueDate => dateTime()();
  BoolColumn get hasExactDay => boolean().withDefault(const Constant(true))();
  TextColumn get provider => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get remindMonthBefore =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get remindDueMonth =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('EventRow')
class EventEntries extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text()();
  TextColumn get title => text()();
  TextColumn get subtitle => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get type => text()();
  RealColumn get amount => real().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get obligationId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [VehicleEntries, ObligationEntries, EventEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'carbase'));

  @override
  int get schemaVersion => 1;
}
