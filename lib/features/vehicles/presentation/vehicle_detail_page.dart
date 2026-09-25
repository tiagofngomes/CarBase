import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/vehicle.dart';
import '../../../core/models/vehicle_event.dart';
import '../../../core/utils/formatters.dart';
import '../../dashboard/presentation/widgets/event_tile.dart';
import '../../records/presentation/event_actions.dart';
import 'vehicle_entry_sheet.dart';

class VehicleDetailPage extends StatefulWidget {
  const VehicleDetailPage({
    super.key,
    required this.vehicle,
    required this.events,
    required this.onVehicleSaved,
    required this.onEventSaved,
    required this.onEventDeleted,
  });

  final Vehicle vehicle;
  final List<VehicleEvent> events;
  final ValueChanged<Vehicle> onVehicleSaved;
  final ValueChanged<VehicleEvent> onEventSaved;
  final ValueChanged<VehicleEvent> onEventDeleted;

  @override
  State<VehicleDetailPage> createState() => _VehicleDetailPageState();
}

class _VehicleDetailPageState extends State<VehicleDetailPage> {
  late Vehicle _vehicle;

  @override
  void initState() {
    super.initState();
    _vehicle = widget.vehicle;
  }

  @override
  Widget build(BuildContext context) {
    final vehicleEvents = widget.events
        .where((event) => event.vehicleId == _vehicle.id)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(_vehicle.displayName),
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: _editVehicle,
            tooltip: 'Editar veículo',
            icon: const Icon(Icons.edit_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: Color(_vehicle.color),
              borderRadius: BorderRadius.circular(26),
              gradient: LinearGradient(
                colors: [Color(_vehicle.color), AppColors.blue],
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
                  _vehicle.licensePlate,
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
                    value: Formatters.kilometers(_vehicle.mileage),
                    onEdit: _editVehicle,
                    editTooltip: 'Atualizar quilometragem',
                  ),
                  const Divider(height: 28),
                  _InfoRow(
                    icon: Icons.calendar_month_rounded,
                    label: 'Ano',
                    value: _vehicle.year.toString(),
                  ),
                  const Divider(height: 28),
                  _InfoRow(
                    icon: Icons.person_rounded,
                    label: 'Associado a',
                    value: _vehicle.associationLabel,
                  ),
                  const Divider(height: 28),
                  _InfoRow(
                    icon: Icons.fact_check_rounded,
                    label: 'Próxima inspeção',
                    value: Formatters.fullDate(_vehicle.nextInspection),
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
          if (vehicleEvents.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(22),
                child: Center(child: Text('Ainda não existem registos.')),
              ),
            )
          else
            for (final event in vehicleEvents) ...[
              EventCard(
                event: event,
                onEdit: () =>
                    EventActions.edit(context, event, widget.onEventSaved),
                onDelete: () =>
                    EventActions.delete(context, event, widget.onEventDeleted),
              ),
              const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }

  Future<void> _editVehicle() async {
    final updated = await VehicleEntrySheet.show(context, existing: _vehicle);
    if (updated == null || !mounted) return;
    setState(() => _vehicle = updated);
    widget.onVehicleSaved(updated);
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onEdit,
    this.editTooltip,
  });
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onEdit;
  final String? editTooltip;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: AppColors.blue, size: 22),
      const SizedBox(width: 12),
      Expanded(child: Text(label)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      if (onEdit != null) ...[
        const SizedBox(width: 4),
        IconButton(
          onPressed: onEdit,
          tooltip: editTooltip,
          visualDensity: VisualDensity.compact,
          icon: const Icon(Icons.edit_rounded, size: 19),
        ),
      ],
    ],
  );
}
