import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/models/record_type.dart';
import '../../../../core/models/recurring_obligation.dart';
import '../../../../core/models/vehicle.dart';
import '../../../../core/models/vehicle_event.dart';
import '../../../obligations/presentation/obligation_setup_sheet.dart';
import '../../../records/presentation/record_entry_sheet.dart';
import '../../../vehicles/presentation/mileage_update_sheet.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    required this.vehicle,
    required this.obligations,
    required this.onVehicleSaved,
    required this.onObligationSaved,
    required this.onEventSaved,
  });

  final Vehicle vehicle;
  final List<RecurringObligation> obligations;
  final ValueChanged<Vehicle> onVehicleSaved;
  final ValueChanged<RecurringObligation> onObligationSaved;
  final ValueChanged<VehicleEvent> onEventSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Prazos e avisos', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Row(
          children: [
            _ActionButton(
              label: 'IUC',
              icon: RecordType.iuc.icon,
              color: AppColors.navy,
              onTap: () => _openObligation(context, RecordType.iuc),
            ),
            const SizedBox(width: 8),
            _ActionButton(
              label: 'Seguro',
              icon: RecordType.insurance.icon,
              color: AppColors.blue,
              onTap: () => _openObligation(context, RecordType.insurance),
            ),
            const SizedBox(width: 8),
            _ActionButton(
              label: 'Inspeção',
              icon: RecordType.inspection.icon,
              color: AppColors.brightBlue,
              onTap: () => _openObligation(context, RecordType.inspection),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Text('Registo rápido', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Row(
          children: [
            _ActionButton(
              label: 'Manutenção',
              icon: RecordType.maintenance.icon,
              color: AppColors.warning,
              onTap: () => RecordEntrySheet.show(
                context,
                RecordType.maintenance,
                vehicle,
                onEventSaved,
              ),
            ),
            const SizedBox(width: 8),
            _ActionButton(
              label: 'Outra despesa',
              icon: RecordType.otherExpense.icon,
              color: AppColors.success,
              onTap: () => RecordEntrySheet.show(
                context,
                RecordType.otherExpense,
                vehicle,
                onEventSaved,
              ),
            ),
            const SizedBox(width: 8),
            _ActionButton(
              label: 'Atualizar km',
              icon: Icons.speed_rounded,
              color: AppColors.navy,
              onTap: () => _updateMileage(context),
            ),
          ],
        ),
      ],
    );
  }

  void _openObligation(BuildContext context, RecordType type) {
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
  }

  Future<void> _updateMileage(BuildContext context) async {
    final updated = await MileageUpdateSheet.show(context, vehicle);
    if (updated != null) onVehicleSaved(updated);
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 92,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 23),
                ),
                const SizedBox(height: 7),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
