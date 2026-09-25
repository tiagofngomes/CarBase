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
  });

  final String id;
  final String make;
  final String model;
  final int year;
  final String licensePlate;
  final int mileage;
  final DateTime nextInspection;
  final int color;

  String get displayName => '$make $model';
}
