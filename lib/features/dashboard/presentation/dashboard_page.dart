import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/vehicle.dart';
import '../../../core/models/vehicle_event.dart';
import '../../../core/models/recurring_obligation.dart';
import '../../../core/models/record_type.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/app_notice.dart';
import '../../obligations/presentation/obligation_reminder_card.dart';
import '../../obligations/presentation/obligation_setup_sheet.dart';
import '../../obligations/presentation/payment_confirmation_sheet.dart';
import '../../obligations/presentation/inspection_completion_sheet.dart';
import '../../records/presentation/event_actions.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/event_tile.dart';
import 'widgets/quick_actions.dart';
import 'widgets/vehicle_hero_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.selectedVehicleId,
    required this.vehicles,
    required this.onVehicleChanged,
    required this.obligations,
    required this.events,
    required this.onVehicleSaved,
    required this.onObligationSaved,
    required this.onObligationPaid,
    required this.onInspectionCompleted,
    required this.onEventSaved,
    required this.onEventDeleted,
    required this.onViewAllEvents,
  });

  final String selectedVehicleId;
  final List<Vehicle> vehicles;
  final ValueChanged<String> onVehicleChanged;
  final List<RecurringObligation> obligations;
  final List<VehicleEvent> events;
  final ValueChanged<Vehicle> onVehicleSaved;
  final ValueChanged<RecurringObligation> onObligationSaved;
  final void Function(
    RecurringObligation obligation,
    double amount,
    DateTime paidAt,
    String? notes,
  )
  onObligationPaid;
  final void Function(
    RecurringObligation obligation,
    DateTime completedAt,
    DateTime nextInspection,
    String result,
    double amount,
    String? notes,
  )
  onInspectionCompleted;
  final ValueChanged<VehicleEvent> onEventSaved;
  final ValueChanged<VehicleEvent> onEventDeleted;
  final VoidCallback onViewAllEvents;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final PageController _pageController;

  int get _selectedIndex => widget.vehicles.indexWhere(
    (vehicle) => vehicle.id == widget.selectedVehicleId,
  );

  Vehicle get _selectedVehicle => widget.vehicles[_selectedIndex];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: .94,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleEvents = widget.events
        .where((event) => event.vehicleId == widget.selectedVehicleId)
        .take(3)
        .toList();
    final vehicleObligations =
        widget.obligations
            .where((item) => item.vehicleId == widget.selectedVehicleId)
            .toList()
          ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));

    return CustomScrollView(
      key: const PageStorageKey('dashboard'),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          sliver: SliverList.list(
            children: [
              const DashboardHeader(),
              const SizedBox(height: 24),
              SizedBox(
                height: 226,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.vehicles.length,
                  onPageChanged: (index) =>
                      widget.onVehicleChanged(widget.vehicles[index].id),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      right: index < widget.vehicles.length - 1 ? 10 : 0,
                    ),
                    child: VehicleHeroCard(vehicle: widget.vehicles[index]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < widget.vehicles.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: i == _selectedIndex ? 20 : 7,
                      height: 7,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: i == _selectedIndex
                            ? AppColors.blue
                            : AppColors.border,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              QuickActions(
                vehicle: _selectedVehicle,
                obligations: widget.obligations,
                onVehicleSaved: widget.onVehicleSaved,
                onObligationSaved: widget.onObligationSaved,
                onEventSaved: widget.onEventSaved,
              ),
              const SizedBox(height: 24),
              const SectionHeader(title: 'Próximos compromissos'),
              const SizedBox(height: 12),
              for (final obligation in vehicleObligations) ...[
                const SizedBox(height: 10),
                ObligationReminderCard(
                  obligation: obligation,
                  onPaid: () => _completeObligation(context, obligation),
                  onEdit: () => _editObligation(context, obligation),
                ),
              ],
              const SizedBox(height: 24),
              SectionHeader(
                title: 'Atividade recente',
                actionLabel: 'Ver tudo',
                onAction: widget.onViewAllEvents,
              ),
              const SizedBox(height: 8),
              if (vehicleEvents.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(22),
                    child: Text('Ainda não existem registos.'),
                  ),
                )
              else
                for (final event in vehicleEvents) ...[
                  EventCard(
                    event: event,
                    onEdit: () =>
                        EventActions.edit(context, event, widget.onEventSaved),
                    onDelete: () => EventActions.delete(
                      context,
                      event,
                      widget.onEventDeleted,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
            ],
          ),
        ),
      ],
    );
  }

  void _editObligation(BuildContext context, RecurringObligation obligation) {
    ObligationSetupSheet.show(
      context: context,
      vehicle: _selectedVehicle,
      type: obligation.type,
      existing: obligation,
      onSave: widget.onObligationSaved,
    );
  }

  Future<void> _completeObligation(
    BuildContext context,
    RecurringObligation obligation,
  ) async {
    if (obligation.type == RecordType.inspection) {
      final inspection = await InspectionCompletionSheet.show(context);
      if (inspection == null || !context.mounted) return;
      widget.onInspectionCompleted(
        obligation,
        inspection.completedAt,
        inspection.nextInspection,
        inspection.result,
        inspection.amount,
        inspection.notes,
      );
      AppNotice.show(context, 'Inspeção registada com sucesso.');
      return;
    }
    final payment = await PaymentConfirmationSheet.show(context, obligation);
    if (payment == null || !context.mounted) return;
    widget.onObligationPaid(
      obligation,
      payment.amount,
      payment.paidAt,
      payment.notes,
    );
    final next = obligation.markAsPaid();
    final type = obligation.type == RecordType.iuc ? 'IUC' : 'Seguro';
    AppNotice.show(
      context,
      '$type pago. Próximo aviso: ${next.nextDueDate.month}/${next.nextDueDate.year}.',
    );
  }
}
