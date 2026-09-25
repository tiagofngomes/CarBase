class Vehicle {
  const Vehicle({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.licensePlate,
    required this.mileage,
    required this.nextInspection,
    required this.color,
    this.associatedPerson,
  });

  final String id;
  final String make;
  final String model;
  final int year;
  final String licensePlate;
  final int mileage;
  final DateTime nextInspection;
  final int color;
  final String? associatedPerson;

  String get displayName => '$make $model';

  String get associationLabel => associatedPerson?.trim().isNotEmpty == true
      ? associatedPerson!.trim()
      : 'Sem pessoa associada';
}
