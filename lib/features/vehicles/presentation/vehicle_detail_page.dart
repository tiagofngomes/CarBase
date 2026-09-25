import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/vehicle.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/demo_data.dart';
import '../../dashboard/presentation/widgets/event_tile.dart';

class VehicleDetailPage extends StatelessWidget {
  const VehicleDetailPage({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.displayName),
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: Color(vehicle.color),
              borderRadius: BorderRadius.circular(26),
              gradient: LinearGradient(
                colors: [Color(vehicle.color), AppColors.blue],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.directions_car_filled_rounded,
                  color: Colors.white,
                  size: 78,
                ),
                const SizedBox(height: 12),
                Text(
                  vehicle.licensePlate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.speed_rounded,
                    label: 'Quilometragem',
                    value: Formatters.kilometers(vehicle.mileage),
                  ),
                  const Divider(height: 28),
                  _InfoRow(
                    icon: Icons.calendar_month_rounded,
                    label: 'Ano',
                    value: vehicle.year.toString(),
                  ),
                  const Divider(height: 28),
                  _InfoRow(
                    icon: Icons.fact_check_rounded,
                    label: 'Próxima inspeção',
                    value: Formatters.fullDate(vehicle.nextInspection),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Últimos registos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  for (var i = 0; i < DemoData.events.length; i++)
                    EventTile(
                      event: DemoData.events[i],
                      showDivider: i < DemoData.events.length - 1,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: AppColors.blue, size: 22),
      const SizedBox(width: 12),
      Expanded(child: Text(label)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
    ],
  );
}
