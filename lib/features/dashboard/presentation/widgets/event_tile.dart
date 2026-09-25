import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/models/vehicle_event.dart';
import '../../../../core/utils/formatters.dart';

class EventTile extends StatelessWidget {
  const EventTile({super.key, required this.event, this.showDivider = true});

  final VehicleEvent event;
  final bool showDivider;

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
                  ],
                ),
              ),
              if (event.amount != null)
                Text(
                  Formatters.currency(event.amount!),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1, indent: 56),
      ],
    );
  }
}
