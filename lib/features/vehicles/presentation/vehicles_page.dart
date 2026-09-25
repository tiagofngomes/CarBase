import 'package:flutter/material.dart';

import '../../../data/demo_data.dart';
import '../../../shared/widgets/page_header.dart';
import 'vehicle_detail_page.dart';
import 'widgets/vehicle_card.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('vehicles'),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
      children: [
        PageHeader(
          title: 'A minha garagem',
          subtitle: '${DemoData.vehicles.length} veículos registados',
          action: IconButton.filled(
            onPressed: () => _showAddVehicle(context),
            tooltip: 'Adicionar veículo',
            icon: const Icon(Icons.add_rounded),
          ),
        ),
        const SizedBox(height: 24),
        for (final vehicle in DemoData.vehicles) ...[
          VehicleCard(
            vehicle: vehicle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VehicleDetailPage(vehicle: vehicle),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  void _showAddVehicle(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          18,
          24,
          24 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adicionar veículo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Marca'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Modelo'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Matrícula',
                prefixIcon: Icon(Icons.pin_rounded),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Quilometragem',
                prefixIcon: Icon(Icons.speed_rounded),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Adicionar à garagem'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
