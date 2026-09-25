import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/recurring_obligation.dart';
import '../../../core/models/record_type.dart';
import '../../../core/models/vehicle_event.dart';
import '../../../data/demo_data.dart';
import '../../activity/presentation/activity_page.dart';
import '../../dashboard/presentation/dashboard_page.dart';
import '../../expenses/presentation/expenses_page.dart';
import '../../vehicles/presentation/vehicles_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  String _selectedVehicleId = '1';
  final List<RecurringObligation> _obligations = List.of(DemoData.obligations);
  final List<VehicleEvent> _events = List.of(DemoData.events);

  void _saveObligation(RecurringObligation obligation) {
    setState(() {
      final index = _obligations.indexWhere((item) => item.id == obligation.id);
      if (index == -1) {
        _obligations.add(obligation);
      } else {
        _obligations[index] = obligation;
      }
    });
  }

  void _saveEvent(VehicleEvent event) {
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
          }
        }
      } else {
        _events[index] = event;
      }
    });
  }

  void _deleteEvent(VehicleEvent event) {
    setState(() {
      _events.removeWhere((item) => item.id == event.id);
      if (event.obligationId != null) {
        final index = _obligations.indexWhere(
          (item) => item.id == event.obligationId,
        );
        if (index != -1) {
          _obligations[index] = _obligations[index].revertLatestPayment();
        }
      }
    });
  }

  void _markObligationPaid(
    RecurringObligation obligation,
    double amount,
    DateTime paidAt,
    String? notes,
  ) {
    setState(() {
      final index = _obligations.indexWhere((item) => item.id == obligation.id);
      if (index != -1) {
        _obligations[index] = _obligations[index].markAsPaid();
      }
      final isIuc = obligation.type == RecordType.iuc;
      _events.insert(
        0,
        VehicleEvent(
          id: 'payment-${DateTime.now().microsecondsSinceEpoch}',
          vehicleId: obligation.vehicleId,
          title: isIuc ? 'IUC pago' : 'Seguro pago',
          subtitle: isIuc
              ? 'Pagamento anual registado'
              : '${obligation.frequency.label} · ${obligation.provider ?? 'Seguro automóvel'}',
          date: paidAt,
          type: obligation.type,
          amount: amount,
          notes: notes,
          obligationId: obligation.id,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(
        selectedVehicleId: _selectedVehicleId,
        obligations: _obligations,
        events: _events,
        onEventSaved: _saveEvent,
        onEventDeleted: _deleteEvent,
        onObligationSaved: _saveObligation,
        onObligationPaid: _markObligationPaid,
        onVehicleChanged: (vehicleId) {
          setState(() => _selectedVehicleId = vehicleId);
        },
      ),
      VehiclesPage(
        events: _events,
        onEventSaved: _saveEvent,
        onEventDeleted: _deleteEvent,
      ),
      ActivityPage(
        events: _events,
        onEventSaved: _saveEvent,
        onEventDeleted: _deleteEvent,
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
