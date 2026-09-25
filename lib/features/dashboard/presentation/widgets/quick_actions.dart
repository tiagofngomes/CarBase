import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/models/record_type.dart';
import '../../../../core/models/recurring_obligation.dart';
import '../../../../core/models/vehicle.dart';
import '../../../../core/models/vehicle_event.dart';
import '../../../obligations/presentation/obligation_setup_sheet.dart';
import '../../../records/presentation/record_entry_sheet.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    required this.vehicle,
    required this.obligations,
    required this.onObligationSaved,
    required this.onEventSaved,
  });

  final Vehicle vehicle;
  final List<RecurringObligation> obligations;
  final ValueChanged<RecurringObligation> onObligationSaved;
  final ValueChanged<VehicleEvent> onEventSaved;

  @override
  Widget build(BuildContext context) {
    const actions = [
      (RecordType.maintenance, AppColors.warning),
      (RecordType.iuc, AppColors.navy),
      (RecordType.insurance, AppColors.blue),
      (RecordType.otherExpense, AppColors.success),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: actions
          .map(
            (action) => Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => _openAction(context, action.$1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: action.$2.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Icon(action.$1.icon, color: action.$2),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        action.$1.label,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  void _openAction(BuildContext context, RecordType type) {
    if (type == RecordType.iuc || type == RecordType.insurance) {
      final matching = obligations.where(
        (item) => item.vehicleId == vehicle.id && item.type == type,
      );
      ObligationSetupSheet.show(
        context: context,
        vehicle: vehicle,
        type: type,
        existing: matching.isEmpty ? null : matching.first,
        onSave: onObligationSaved,
      );
      return;
    }
    RecordEntrySheet.show(context, type, vehicle, onEventSaved);
  }
}
