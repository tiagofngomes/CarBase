import 'package:flutter/material.dart';

import '../../../core/models/vehicle.dart';
import '../../../core/models/vehicle_event.dart';
import '../../../shared/widgets/page_header.dart';
import 'vehicle_detail_page.dart';
import 'vehicle_entry_sheet.dart';
import 'widgets/vehicle_card.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({
    super.key,
    required this.events,
    required this.vehicles,
    required this.onVehicleSaved,
    required this.onEventSaved,
    required this.onEventDeleted,
  });

  final List<VehicleEvent> events;
  final List<Vehicle> vehicles;
  final ValueChanged<Vehicle> onVehicleSaved;
  final ValueChanged<VehicleEvent> onEventSaved;
  final ValueChanged<VehicleEvent> onEventDeleted;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('vehicles'),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
      children: [
        PageHeader(
          title: 'A minha garagem',
          subtitle: '${vehicles.length} veículos registados',
          action: IconButton.filled(
            onPressed: () => _showAddVehicle(context),
            tooltip: 'Adicionar veículo',
            icon: const Icon(Icons.add_rounded),
          ),
        ),
        const SizedBox(height: 24),
        for (final vehicle in vehicles) ...[
          VehicleCard(
            vehicle: vehicle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VehicleDetailPage(
                  vehicle: vehicle,
                  events: events,
                  onEventSaved: onEventSaved,
                  onEventDeleted: onEventDeleted,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Future<void> _showAddVehicle(BuildContext context) async {
    final vehicle = await VehicleEntrySheet.show(context);
    if (vehicle != null) onVehicleSaved(vehicle);
  }
}
