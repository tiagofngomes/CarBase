import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/vehicle_event.dart';
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
    ValueChanged<VehicleEvent> onRestore,
  ) async {
    final isPayment = event.obligationId != null;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.delete_outline_rounded, color: AppColors.danger),
        title: Text(isPayment ? 'Anular pagamento?' : 'Eliminar registo?'),
        content: Text(
          isPayment
              ? 'O pagamento será removido do histórico e o vencimento anterior será reposto.'
              : 'Este registo será removido do histórico.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(context, true),
            child: Text(isPayment ? 'Anular pagamento' : 'Eliminar'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    onDelete(event);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isPayment ? 'Pagamento anulado.' : 'Registo eliminado.'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () => onRestore(event),
        ),
      ),
    );
  }
}
