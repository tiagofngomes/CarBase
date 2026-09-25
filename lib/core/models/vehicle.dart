import 'package:flutter/material.dart';

enum VehicleType {
  car('Carro', Icons.directions_car_filled_rounded),
  motorcycle('Mota', Icons.two_wheeler_rounded);

  const VehicleType(this.label, this.icon);

  final String label;
  final IconData icon;
}

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
    this.type = VehicleType.car,
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
  final VehicleType type;

  String get displayName => '$make $model';

  String get associationLabel => associatedPerson?.trim().isNotEmpty == true
      ? associatedPerson!.trim()
      : 'Sem pessoa associada';

  Vehicle copyWith({
    String? make,
    String? model,
    int? year,
    String? licensePlate,
    int? mileage,
    DateTime? nextInspection,
    int? color,
    String? associatedPerson,
    VehicleType? type,
  }) {
    return Vehicle(
      id: id,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      licensePlate: licensePlate ?? this.licensePlate,
      mileage: mileage ?? this.mileage,
      nextInspection: nextInspection ?? this.nextInspection,
      color: color ?? this.color,
      associatedPerson: associatedPerson ?? this.associatedPerson,
      type: type ?? this.type,
    );
  }
}
