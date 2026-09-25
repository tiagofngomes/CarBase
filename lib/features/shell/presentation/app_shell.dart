import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/recurring_obligation.dart';
import '../../../core/models/record_type.dart';
import '../../../core/models/vehicle.dart';
import '../../../core/models/vehicle_event.dart';
import '../../../data/local/carbase_repository.dart';
import '../../activity/presentation/activity_page.dart';
import '../../dashboard/presentation/dashboard_page.dart';
import '../../expenses/presentation/expenses_page.dart';
import '../../vehicles/presentation/vehicles_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.repository,
    required this.initialData,
  });

  final CarBaseRepository repository;
  final CarBaseSnapshot initialData;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  late String _selectedVehicleId;
  String? _activityVehicleId;
  late final List<Vehicle> _vehicles;
  late final List<RecurringObligation> _obligations;
  late final List<VehicleEvent> _events;

  @override
  void initState() {
    super.initState();
    _vehicles = List.of(widget.initialData.vehicles);
    _obligations = List.of(widget.initialData.obligations);
    _events = List.of(widget.initialData.events);
    _selectedVehicleId = _vehicles.first.id;
  }

  void _saveObligation(RecurringObligation obligation) {
    setState(() {
      final index = _obligations.indexWhere((item) => item.id == obligation.id);
      if (index == -1) {
        _obligations.add(obligation);
      } else {
        _obligations[index] = obligation;
      }
    });
    unawaited(widget.repository.saveObligation(obligation));
  }

  void _saveVehicle(Vehicle vehicle) {
    setState(() {
      final index = _vehicles.indexWhere((item) => item.id == vehicle.id);
      if (index == -1) {
        _vehicles.add(vehicle);
      } else {
        _vehicles[index] = vehicle;
      }
    });
    unawaited(widget.repository.saveVehicle(vehicle));
  }

  void _saveEvent(VehicleEvent event) {
    RecurringObligation? updatedObligation;
    setState(() {
      final index = _events.indexWhere((item) => item.id == event.id);
      if (index == -1) {
        _events.insert(0, event);
        if (event.obligationId != null) {
          final obligationIndex = _obligations.indexWhere(
            (item) => item.id == event.obligationId,
          );
          if (obligationIndex != -1) {
            _obligations[obligationIndex] = _obligations[obligationIndex]
                .markAsPaid();
            updatedObligation = _obligations[obligationIndex];
          }
        }
      } else {
        _events[index] = event;
      }
    });
    unawaited(widget.repository.saveEvent(event));
    if (updatedObligation != null) {
      unawaited(widget.repository.saveObligation(updatedObligation!));
    }
  }

  void _deleteEvent(VehicleEvent event) {
    RecurringObligation? updatedObligation;
    setState(() {
      _events.removeWhere((item) => item.id == event.id);
      if (event.obligationId != null) {
        final index = _obligations.indexWhere(
          (item) => item.id == event.obligationId,
        );
        if (index != -1) {
          _obligations[index] = _obligations[index].revertLatestPayment();
          updatedObligation = _obligations[index];
        }
      }
    });
    unawaited(widget.repository.deleteEvent(event.id));
    if (updatedObligation != null) {
      unawaited(widget.repository.saveObligation(updatedObligation!));
    }
  }

  void _markObligationPaid(
    RecurringObligation obligation,
    double amount,
    DateTime paidAt,
    String? notes,
  ) {
    late final RecurringObligation updatedObligation;
    late final VehicleEvent paymentEvent;
    setState(() {
      final index = _obligations.indexWhere((item) => item.id == obligation.id);
      if (index != -1) {
        _obligations[index] = _obligations[index].markAsPaid();
        updatedObligation = _obligations[index];
      }
      final isIuc = obligation.type == RecordType.iuc;
      paymentEvent = VehicleEvent(
        id: 'payment-${DateTime.now().microsecondsSinceEpoch}',
        vehicleId: obligation.vehicleId,
        title: isIuc ? 'IUC pago' : 'Seguro pago',
        subtitle: isIuc
            ? 'Pagamento anual registado'
            : '${obligation.frequency.label} · ${obligation.provider ?? 'Seguro do veículo'}',
        date: paidAt,
        type: obligation.type,
        amount: amount,
        notes: notes,
        obligationId: obligation.id,
      );
      _events.insert(0, paymentEvent);
    });
    unawaited(widget.repository.saveObligation(updatedObligation));
    unawaited(widget.repository.saveEvent(paymentEvent));
  }

  void _completeInspection(
    RecurringObligation obligation,
    DateTime completedAt,
    DateTime nextInspection,
    String result,
    double amount,
    String? notes,
  ) {
    final updated = obligation.copyWith(nextDueDate: nextInspection);
    final event = VehicleEvent(
      id: 'inspection-${DateTime.now().microsecondsSinceEpoch}',
      vehicleId: obligation.vehicleId,
      title: 'Inspeção periódica',
      subtitle:
          '$result · Próxima em ${nextInspection.month}/${nextInspection.year}',
      date: completedAt,
      type: RecordType.inspection,
      amount: amount,
      notes: notes,
      obligationId: obligation.id,
    );
    setState(() {
      final index = _obligations.indexWhere((item) => item.id == obligation.id);
      if (index != -1) _obligations[index] = updated;
      _events.insert(0, event);
    });
    unawaited(widget.repository.saveObligation(updated));
    unawaited(widget.repository.saveEvent(event));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(
        selectedVehicleId: _selectedVehicleId,
        vehicles: _vehicles,
        obligations: _obligations,
        events: _events,
        onVehicleSaved: _saveVehicle,
        onEventSaved: _saveEvent,
        onEventDeleted: _deleteEvent,
        onObligationSaved: _saveObligation,
        onObligationPaid: _markObligationPaid,
        onInspectionCompleted: _completeInspection,
        onVehicleChanged: (vehicleId) {
          setState(() => _selectedVehicleId = vehicleId);
        },
        onViewAllEvents: () {
          setState(() {
            _activityVehicleId = _selectedVehicleId;
            _index = 2;
          });
        },
      ),
      VehiclesPage(
        vehicles: _vehicles,
        events: _events,
        onVehicleSaved: _saveVehicle,
        onEventSaved: _saveEvent,
        onEventDeleted: _deleteEvent,
      ),
      ActivityPage(
        vehicles: _vehicles,
        events: _events,
        onEventSaved: _saveEvent,
        onEventDeleted: _deleteEvent,
        selectedVehicleId: _activityVehicleId,
        onVehicleChanged: (vehicleId) {
          setState(() => _activityVehicleId = vehicleId);
        },
      ),
      const ExpensesPage(),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _index, children: pages),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (value) => setState(() => _index = value),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: AppStrings.home,
            ),
            NavigationDestination(
              icon: Icon(Icons.directions_car_outlined),
              selectedIcon: Icon(Icons.directions_car_rounded),
              label: AppStrings.vehicles,
            ),
            NavigationDestination(
              icon: Icon(Icons.history_rounded),
              selectedIcon: Icon(Icons.history_rounded),
              label: AppStrings.activity,
            ),
            NavigationDestination(
              icon: Icon(Icons.pie_chart_outline_rounded),
              selectedIcon: Icon(Icons.pie_chart_rounded),
              label: AppStrings.expenses,
            ),
          ],
        ),
      ),
    );
  }
}
