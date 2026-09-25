import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/record_type.dart';
import '../../../core/models/vehicle_event.dart';
import '../../../core/models/vehicle.dart';
import '../../../shared/widgets/page_header.dart';
import '../../dashboard/presentation/widgets/event_tile.dart';
import '../../records/presentation/event_actions.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({
    super.key,
    required this.events,
    required this.vehicles,
    required this.onEventSaved,
    required this.onEventDeleted,
  });

  final List<VehicleEvent> events;
  final List<Vehicle> vehicles;
  final ValueChanged<VehicleEvent> onEventSaved;
  final ValueChanged<VehicleEvent> onEventDeleted;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  RecordType? _filter;
  String? _vehicleId;

  @override
  Widget build(BuildContext context) {
    final events = widget.events.where((event) {
      final matchesVehicle =
          _vehicleId == null || event.vehicleId == _vehicleId;
      final matchesType = _filter == null || event.type == _filter;
      return matchesVehicle && matchesType;
    }).toList();

    return ListView(
      key: const PageStorageKey('activity'),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
      children: [
        const PageHeader(
          title: 'Histórico',
          subtitle: 'Todos os acontecimentos dos seus veículos',
        ),
        const SizedBox(height: 22),
        Text('Veículo', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: 'Todos',
                selected: _vehicleId == null,
                onTap: () => setState(() => _vehicleId = null),
              ),
              for (final vehicle in widget.vehicles)
                _FilterChip(
                  label: '${vehicle.displayName} · ${vehicle.associationLabel}',
                  selected: _vehicleId == vehicle.id,
                  onTap: () => setState(() => _vehicleId = vehicle.id),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Tipo de registo', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: 'Todos',
                selected: _filter == null,
                onTap: () => setState(() => _filter = null),
              ),
              _FilterChip(
                label: 'Manutenção',
                selected: _filter == RecordType.maintenance,
                onTap: () => setState(() => _filter = RecordType.maintenance),
              ),
              _FilterChip(
                label: 'Seguro',
                selected: _filter == RecordType.insurance,
                onTap: () => setState(() => _filter = RecordType.insurance),
              ),
              _FilterChip(
                label: 'IUC',
                selected: _filter == RecordType.iuc,
                onTap: () => setState(() => _filter = RecordType.iuc),
              ),
              _FilterChip(
                label: 'Outras despesas',
                selected: _filter == RecordType.otherExpense,
                onTap: () => setState(() => _filter = RecordType.otherExpense),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text('2026', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        if (events.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(28),
              child: Center(child: Text('Sem registos nesta categoria.')),
            ),
          )
        else
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  for (var i = 0; i < events.length; i++)
                    EventTile(
                      event: events[i],
                      showDivider: i < events.length - 1,
                      onEdit: () => EventActions.edit(
                        context,
                        events[i],
                        widget.onEventSaved,
                      ),
                      onDelete: () => EventActions.delete(
                        context,
                        events[i],
                        widget.onEventDeleted,
                        widget.onEventSaved,
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 8),
    child: ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.blue.withValues(alpha: .14),
      side: BorderSide(color: selected ? AppColors.blue : AppColors.border),
      labelStyle: TextStyle(
        color: selected ? AppColors.blue : AppColors.muted,
        fontWeight: FontWeight.w600,
      ),
      showCheckmark: false,
    ),
  );
}
