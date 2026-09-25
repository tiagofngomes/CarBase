import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            'assets/branding/carbase_logo.png',
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.greeting,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Aqui está o resumo da sua garagem',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          tooltip: 'Notificações',
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Não existem novas notificações.')),
          ),
          icon: const Badge(
            smallSize: 7,
            backgroundColor: AppColors.danger,
            child: Icon(Icons.notifications_none_rounded),
          ),
        ),
      ],
    );
  }
}
