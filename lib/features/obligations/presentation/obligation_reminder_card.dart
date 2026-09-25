import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/record_type.dart';
import '../../../core/models/recurring_obligation.dart';

class ObligationReminderCard extends StatelessWidget {
  const ObligationReminderCard({
    super.key,
    required this.obligation,
    required this.onPaid,
    required this.onEdit,
  });

  final RecurringObligation obligation;
  final VoidCallback onPaid;
  final VoidCallback onEdit;

  static const _months = [
    'janeiro',
    'fevereiro',
    'março',
    'abril',
    'maio',
    'junho',
    'julho',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'dezembro',
  ];

  @override
  Widget build(BuildContext context) {
    final color = obligation.type == RecordType.iuc
        ? AppColors.navy
        : AppColors.blue;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 12, 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(obligation.type.icon, color: color),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            obligation.type.label,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(width: 7),
                          _StatusBadge(
                            label: _statusLabel,
                            color: _statusColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${obligation.frequency.label} · $_dueLabel',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Editar avisos',
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.notifications_active_rounded,
                  size: 17,
                  color: AppColors.muted,
                ),
                const SizedBox(width: 6),
                const Expanded(
                  child: Text(
                    'Avisos: 1 mês antes e no próprio mês',
                    style: TextStyle(fontSize: 11, color: AppColors.muted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onPaid,
                icon: const Icon(Icons.check_circle_outline_rounded, size: 19),
                label: const Text('Marcar como pago'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _dueLabel {
    final date = obligation.nextDueDate;
    final month = _months[date.month - 1];
    return obligation.hasExactDay
        ? '${date.day} de $month de ${date.year}'
        : '$month de ${date.year}';
  }

  String get _statusLabel {
    final now = DateTime.now();
    final monthDistance =
        (obligation.nextDueDate.year - now.year) * 12 +
        obligation.nextDueDate.month -
        now.month;
    if (monthDistance <= 0) return 'Este mês';
    if (monthDistance == 1) return 'Próximo mês';
    return 'Agendado';
  }

  Color get _statusColor {
    final now = DateTime.now();
    final monthDistance =
        (obligation.nextDueDate.year - now.year) * 12 +
        obligation.nextDueDate.month -
        now.month;
    if (monthDistance <= 0) return AppColors.danger;
    if (monthDistance == 1) return AppColors.warning;
    return AppColors.success;
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
