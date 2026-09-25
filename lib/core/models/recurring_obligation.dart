import 'record_type.dart';

enum PaymentFrequency {
  monthly(1, 'Mensal'),
  quarterly(3, 'Trimestral'),
  semiannual(6, 'Semestral'),
  annual(12, 'Anual');

  const PaymentFrequency(this.months, this.label);

  final int months;
  final String label;
}

class RecurringObligation {
  const RecurringObligation({
    required this.id,
    required this.vehicleId,
    required this.type,
    required this.frequency,
    required this.nextDueDate,
    this.hasExactDay = true,
    this.provider,
    this.remindMonthBefore = true,
    this.remindDueMonth = true,
  });

  final String id;
  final String vehicleId;
  final RecordType type;
  final PaymentFrequency frequency;
  final DateTime nextDueDate;
  final bool hasExactDay;
  final String? provider;
  final bool remindMonthBefore;
  final bool remindDueMonth;

  RecurringObligation markAsPaid() {
    final targetMonth = nextDueDate.month + frequency.months;
    final year = nextDueDate.year + (targetMonth - 1) ~/ 12;
    final month = (targetMonth - 1) % 12 + 1;
    final lastDay = DateTime(year, month + 1, 0).day;
    final day = nextDueDate.day.clamp(1, lastDay);

    return copyWith(nextDueDate: DateTime(year, month, day));
  }

  RecurringObligation copyWith({
    PaymentFrequency? frequency,
    DateTime? nextDueDate,
    bool? hasExactDay,
    String? provider,
    bool? remindMonthBefore,
    bool? remindDueMonth,
  }) {
    return RecurringObligation(
      id: id,
      vehicleId: vehicleId,
      type: type,
      frequency: frequency ?? this.frequency,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      hasExactDay: hasExactDay ?? this.hasExactDay,
      provider: provider ?? this.provider,
      remindMonthBefore: remindMonthBefore ?? this.remindMonthBefore,
      remindDueMonth: remindDueMonth ?? this.remindDueMonth,
    );
  }
}
