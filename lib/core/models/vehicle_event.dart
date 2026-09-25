import 'package:flutter/material.dart';

import 'record_type.dart';

class VehicleEvent {
  const VehicleEvent({
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

  final String id;
  final String vehicleId;
  final String title;
  final String subtitle;
  final DateTime date;
  final RecordType type;
  final double? amount;
  final String? notes;
  final String? obligationId;

  IconData get icon => type.icon;

  VehicleEvent copyWith({
    String? title,
    String? subtitle,
    DateTime? date,
    double? amount,
    String? notes,
  }) {
    return VehicleEvent(
      id: id,
      vehicleId: vehicleId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      type: type,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      obligationId: obligationId,
    );
  }
}
