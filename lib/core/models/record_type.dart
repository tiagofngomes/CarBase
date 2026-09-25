import 'package:flutter/material.dart';

enum RecordType { maintenance, iuc, insurance, otherExpense, inspection }

extension RecordTypePresentation on RecordType {
  String get label => switch (this) {
    RecordType.maintenance => 'Manutenção',
    RecordType.iuc => 'IUC',
    RecordType.insurance => 'Seguro',
    RecordType.otherExpense => 'Outra despesa',
    RecordType.inspection => 'Inspeção',
  };

  IconData get icon => switch (this) {
    RecordType.maintenance => Icons.build_rounded,
    RecordType.iuc => Icons.account_balance_rounded,
    RecordType.insurance => Icons.shield_rounded,
    RecordType.otherExpense => Icons.receipt_long_rounded,
    RecordType.inspection => Icons.fact_check_rounded,
  };
}
