import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../data/demo_data.dart';
import '../../../shared/widgets/section_header.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/event_tile.dart';
import 'widgets/quick_actions.dart';
import 'widgets/upcoming_card.dart';
import 'widgets/vehicle_hero_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey('dashboard'),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          sliver: SliverList.list(
            children: [
              const DashboardHeader(),
              const SizedBox(height: 24),
              VehicleHeroCard(vehicle: DemoData.vehicles.first),
              const SizedBox(height: 22),
              const SectionHeader(title: 'Registo rápido'),
              const SizedBox(height: 6),
              const QuickActions(),
              const SizedBox(height: 24),
              const SectionHeader(title: 'Próximos compromissos'),
              const SizedBox(height: 12),
              UpcomingCard(
                title: 'Inspeção periódica',
                date: DemoData.vehicles.first.nextInspection,
                icon: Icons.fact_check_rounded,
                color: AppColors.warning,
                caption: 'Faltam 54 dias',
              ),
              const SizedBox(height: 10),
              UpcomingCard(
                title: 'Seguro automóvel',
                date: DateTime(2026, 12, 4),
                icon: Icons.shield_rounded,
                color: AppColors.success,
                caption: 'Renovação anual',
              ),
              const SizedBox(height: 10),
              UpcomingCard(
                title: 'Pagamento do IUC',
                date: DateTime(2027, 1, 31),
                icon: Icons.account_balance_rounded,
                color: AppColors.navy,
                caption: 'Prazo de pagamento',
              ),
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Atividade recente',
                actionLabel: 'Ver tudo',
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      for (var i = 0; i < 3; i++)
                        EventTile(
                          event: DemoData.events[i],
                          showDivider: i < 2,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
