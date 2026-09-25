import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';
import '../core/models/expense.dart';
import '../core/models/record_type.dart';
import '../core/models/recurring_obligation.dart';
import '../core/models/vehicle.dart';
import '../core/models/vehicle_event.dart';

abstract final class DemoData {
  static final vehicles = [
    Vehicle(
      id: '1',
      make: 'Volkswagen',
      model: 'Golf',
      year: 2020,
      licensePlate: 'AA-21-XZ',
      mileage: 68420,
      nextInspection: DateTime(2026, 11, 18),
      color: 0xFF244A68,
      associatedPerson: 'Miguel',
    ),
    Vehicle(
      id: '2',
      make: 'Renault',
      model: 'Clio',
      year: 2017,
      licensePlate: '45-TL-92',
      mileage: 112830,
      nextInspection: DateTime(2027, 2, 6),
      color: 0xFF244A68,
      associatedPerson: 'Ana',
    ),
  ];

  static final events = [
    VehicleEvent(
      id: 'event-maintenance-1',
      vehicleId: '1',
      title: 'Mudança de óleo e filtros',
      subtitle: 'Auto Silva · 68.420 km',
      date: DateTime(2026, 9, 18),
      type: RecordType.maintenance,
      amount: 189.90,
    ),
    VehicleEvent(
      id: 'event-insurance-1',
      vehicleId: '1',
      title: 'Renovação do seguro',
      subtitle: 'Fidelidade · Apólice 4829017',
      date: DateTime(2026, 9, 12),
      type: RecordType.insurance,
      amount: 326.80,
    ),
    VehicleEvent(
      id: 'event-inspection-1',
      vehicleId: '2',
      title: 'Inspeção periódica',
      subtitle: 'Aprovado sem anotações',
      date: DateTime(2026, 8, 27),
      type: RecordType.inspection,
      amount: 35.89,
    ),
    VehicleEvent(
      id: 'event-iuc-1',
      vehicleId: '1',
      title: 'IUC 2026',
      subtitle: 'Pago · Autoridade Tributária',
      date: DateTime(2026, 7, 8),
      type: RecordType.iuc,
    ),
    VehicleEvent(
      id: 'event-expense-1',
      vehicleId: '2',
      title: 'Estacionamento mensal',
      subtitle: 'Parque da Estação',
      date: DateTime(2026, 6, 30),
      type: RecordType.otherExpense,
      amount: 45.00,
    ),
  ];

  static const expenseCategories = [
    ExpenseCategory(
      label: 'Manutenção',
      amount: 489.90,
      icon: Icons.build_rounded,
      color: AppColors.warning,
    ),
    ExpenseCategory(
      label: 'Seguro',
      amount: 326.80,
      icon: Icons.shield_rounded,
      color: AppColors.blue,
    ),
    ExpenseCategory(
      label: 'IUC',
      amount: 148.42,
      icon: Icons.account_balance_rounded,
      color: AppColors.navy,
    ),
    ExpenseCategory(
      label: 'Inspeções',
      amount: 35.89,
      icon: Icons.fact_check_rounded,
      color: AppColors.success,
    ),
    ExpenseCategory(
      label: 'Outras despesas',
      amount: 86.20,
      icon: Icons.receipt_long_rounded,
      color: AppColors.danger,
    ),
  ];

  static final obligations = [
    RecurringObligation(
      id: '1-iuc',
      vehicleId: '1',
      type: RecordType.iuc,
      frequency: PaymentFrequency.annual,
      nextDueDate: DateTime(2027, 1, 1),
      hasExactDay: false,
    ),
    RecurringObligation(
      id: '1-insurance',
      vehicleId: '1',
      type: RecordType.insurance,
      frequency: PaymentFrequency.semiannual,
      nextDueDate: DateTime(2026, 12, 4),
      provider: 'Fidelidade',
    ),
    RecurringObligation(
      id: '1-inspection',
      vehicleId: '1',
      type: RecordType.inspection,
      frequency: PaymentFrequency.annual,
      nextDueDate: DateTime(2026, 11, 18),
    ),
    RecurringObligation(
      id: '2-iuc',
      vehicleId: '2',
      type: RecordType.iuc,
      frequency: PaymentFrequency.annual,
      nextDueDate: DateTime(2027, 2, 1),
      hasExactDay: false,
    ),
    RecurringObligation(
      id: '2-insurance',
      vehicleId: '2',
      type: RecordType.insurance,
      frequency: PaymentFrequency.quarterly,
      nextDueDate: DateTime(2026, 10, 15),
      provider: 'Ageas',
    ),
    RecurringObligation(
      id: '2-inspection',
      vehicleId: '2',
      type: RecordType.inspection,
      frequency: PaymentFrequency.annual,
      nextDueDate: DateTime(2027, 2, 6),
    ),
  ];
}
