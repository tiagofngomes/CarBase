import 'package:flutter/material.dart';

import 'record_type.dart';

class VehicleEvent {
  const VehicleEvent({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.type,
    this.amount,
  });

  final String title;
  final String subtitle;
  final DateTime date;
  final RecordType type;
  final double? amount;

  IconData get icon => type.icon;
}
