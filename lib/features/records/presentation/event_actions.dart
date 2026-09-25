import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/vehicle_event.dart';
import '../../../shared/widgets/app_modal.dart';
import 'event_edit_sheet.dart';

abstract final class EventActions {
  static Future<void> edit(
    BuildContext context,
    VehicleEvent event,
    ValueChanged<VehicleEvent> onSave,
  ) async {
    final updated = await EventEditSheet.show(context, event);
    if (updated != null) onSave(updated);
  }

  static Future<void> delete(
    BuildContext context,
    VehicleEvent event,
    ValueChanged<VehicleEvent> onDelete,
  ) async {
    final isPayment = event.obligationId != null;
    final confirmed = await showAppModal<bool>(
      context: context,
      builder: (dialogContext) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(17),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.danger,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isPayment ? 'Anular pagamento?' : 'Eliminar registo?',
              textAlign: TextAlign.center,
              style: Theme.of(dialogContext).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              isPayment
                  ? 'O pagamento será removido do histórico e o vencimento anterior será reposto.'
                  : 'Este registo será removido do histórico.',
              textAlign: TextAlign.center,
              style: Theme.of(dialogContext).textTheme.bodyMedium,
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.danger,
                    ),
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: Text(
                      isPayment ? 'Anular pagamento' : 'Eliminar',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    if (confirmed != true || !context.mounted) return;

    onDelete(event);
  }
}
