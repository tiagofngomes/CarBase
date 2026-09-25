import 'package:drift/drift.dart';

import '../../core/models/record_type.dart';
import '../../core/models/recurring_obligation.dart';
import '../../core/models/vehicle.dart';
import '../../core/models/vehicle_event.dart';
import '../demo_data.dart';
import 'app_database.dart';

class CarBaseSnapshot {
  const CarBaseSnapshot({
    required this.vehicles,
    required this.obligations,
    required this.events,
  });

  final List<Vehicle> vehicles;
  final List<RecurringObligation> obligations;
  final List<VehicleEvent> events;
}

class CarBaseRepository {
  CarBaseRepository(this.database);

  final AppDatabase database;

  Future<CarBaseSnapshot> initialize() async {
    final existingVehicles = await database
        .select(database.vehicleEntries)
        .get();
    if (existingVehicles.isEmpty) {
      await database.transaction(() async {
        for (final vehicle in DemoData.vehicles) {
          await saveVehicle(vehicle);
        }
        for (final obligation in DemoData.obligations) {
          await saveObligation(obligation);
        }
        for (final event in DemoData.events) {
          await saveEvent(event);
        }
      });
    }
    final vehicles = await database.select(database.vehicleEntries).get();
    final obligations = await database.select(database.obligationEntries).get();
    for (final vehicle in vehicles) {
      final hasInspection = obligations.any(
        (item) =>
            item.vehicleId == vehicle.id &&
            item.type == RecordType.inspection.name,
      );
      if (!hasInspection && (vehicle.id == '1' || vehicle.id == '2')) {
        await saveObligation(
          RecurringObligation(
            id: '${vehicle.id}-inspection',
            vehicleId: vehicle.id,
            type: RecordType.inspection,
            frequency: PaymentFrequency.annual,
            nextDueDate: vehicle.nextInspection,
          ),
        );
      }
    }
    return load();
  }

  Future<CarBaseSnapshot> load() async {
    final vehicleRows = await database.select(database.vehicleEntries).get();
    final obligationRows = await database
        .select(database.obligationEntries)
        .get();
    final eventQuery = database.select(database.eventEntries)
      ..orderBy([(row) => OrderingTerm.desc(row.date)]);
    final eventRows = await eventQuery.get();

    return CarBaseSnapshot(
      vehicles: vehicleRows.map(_vehicleFromRow).toList(),
      obligations: obligationRows.map(_obligationFromRow).toList(),
      events: eventRows.map(_eventFromRow).toList(),
    );
  }

  Future<void> saveVehicle(Vehicle vehicle) {
    return database
        .into(database.vehicleEntries)
        .insertOnConflictUpdate(
          VehicleEntriesCompanion.insert(
            id: vehicle.id,
            make: vehicle.make,
            model: vehicle.model,
            year: vehicle.year,
            licensePlate: vehicle.licensePlate,
            mileage: vehicle.mileage,
            nextInspection: vehicle.nextInspection,
            color: vehicle.color,
            associatedPerson: Value(vehicle.associatedPerson),
            vehicleType: Value(vehicle.type.name),
          ),
        );
  }

  Future<void> saveObligation(RecurringObligation item) {
    return database
        .into(database.obligationEntries)
        .insertOnConflictUpdate(
          ObligationEntriesCompanion.insert(
            id: item.id,
            vehicleId: item.vehicleId,
            type: item.type.name,
            frequency: item.frequency.name,
            nextDueDate: item.nextDueDate,
            hasExactDay: Value(item.hasExactDay),
            provider: Value(item.provider),
            notes: Value(item.notes),
            remindMonthBefore: Value(item.remindMonthBefore),
            remindDueMonth: Value(item.remindDueMonth),
          ),
        );
  }

  Future<void> saveEvent(VehicleEvent event) {
    return database
        .into(database.eventEntries)
        .insertOnConflictUpdate(
          EventEntriesCompanion.insert(
            id: event.id,
            vehicleId: event.vehicleId,
            title: event.title,
            subtitle: event.subtitle,
            date: event.date,
            type: event.type.name,
            amount: Value(event.amount),
            notes: Value(event.notes),
            obligationId: Value(event.obligationId),
          ),
        );
  }

  Future<void> deleteEvent(String id) {
    return (database.delete(
      database.eventEntries,
    )..where((row) => row.id.equals(id))).go();
  }

  Vehicle _vehicleFromRow(VehicleRow row) => Vehicle(
    id: row.id,
    make: row.make,
    model: row.model,
    year: row.year,
    licensePlate: row.licensePlate,
    mileage: row.mileage,
    nextInspection: row.nextInspection,
    color: row.color,
    associatedPerson: row.associatedPerson,
    type: VehicleType.values.firstWhere(
      (type) => type.name == row.vehicleType,
      orElse: () => VehicleType.car,
    ),
  );

  RecurringObligation _obligationFromRow(ObligationRow row) =>
      RecurringObligation(
        id: row.id,
        vehicleId: row.vehicleId,
        type: RecordType.values.byName(row.type),
        frequency: PaymentFrequency.values.byName(row.frequency),
        nextDueDate: row.nextDueDate,
        hasExactDay: row.hasExactDay,
        provider: row.provider,
        notes: row.notes,
        remindMonthBefore: row.remindMonthBefore,
        remindDueMonth: row.remindDueMonth,
      );

  VehicleEvent _eventFromRow(EventRow row) => VehicleEvent(
    id: row.id,
    vehicleId: row.vehicleId,
    title: row.title,
    subtitle: row.subtitle,
    date: row.date,
    type: RecordType.values.byName(row.type),
    amount: row.amount,
    notes: row.notes,
    obligationId: row.obligationId,
  );
}
