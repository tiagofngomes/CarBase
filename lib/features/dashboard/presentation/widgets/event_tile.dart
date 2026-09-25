import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/models/vehicle_event.dart';
import '../../../../core/utils/formatters.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.event,
    this.showDivider = true,
    this.onEdit,
    this.onDelete,
  });

  final VehicleEvent event;
  final bool showDivider;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: AppColors.blue.withValues(alpha: .09),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(event.icon, size: 21, color: AppColors.blue),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${Formatters.fullDate(event.date)}  ·  ${event.subtitle}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (event.notes?.isNotEmpty == true) ...[
                      const SizedBox(height: 3),
                      Text(
                        event.notes!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ],
                ),
              ),
              if (event.amount != null)
                Text(
                  Formatters.currency(event.amount!),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              if (onEdit != null || onDelete != null)
                PopupMenuButton<String>(
                  tooltip: 'Opções do registo',
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: AppColors.muted,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') onEdit?.call();
                    if (value == 'delete') onDelete?.call();
                  },
                  itemBuilder: (_) => [
                    if (onEdit != null)
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.edit_outlined),
                          title: Text('Editar'),
                        ),
                      ),
                    if (onDelete != null)
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.danger,
                          ),
                          title: Text(
                            'Eliminar registo',
                            style: TextStyle(color: AppColors.danger),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1, indent: 56),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    this.onEdit,
    this.onDelete,
  });

  final VehicleEvent event;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: EventTile(
          event: event,
          showDivider: false,
          onEdit: onEdit,
          onDelete: onDelete,
        ),
      ),
    );
  }
}
