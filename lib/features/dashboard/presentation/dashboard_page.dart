import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/vehicle.dart';
import '../../../core/models/vehicle_event.dart';
import '../../../core/models/recurring_obligation.dart';
import '../../../core/models/record_type.dart';
import '../../../shared/widgets/section_header.dart';
import '../../obligations/presentation/obligation_reminder_card.dart';
import '../../obligations/presentation/obligation_setup_sheet.dart';
import '../../obligations/presentation/payment_confirmation_sheet.dart';
import '../../records/presentation/event_actions.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/event_tile.dart';
import 'widgets/quick_actions.dart';
import 'widgets/upcoming_card.dart';
import 'widgets/vehicle_hero_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.selectedVehicleId,
    required this.vehicles,
    required this.onVehicleChanged,
    required this.obligations,
    required this.events,
    required this.onObligationSaved,
    required this.onObligationPaid,
    required this.onEventSaved,
    required this.onEventDeleted,
  });

  final String selectedVehicleId;
  final List<Vehicle> vehicles;
  final ValueChanged<String> onVehicleChanged;
  final List<RecurringObligation> obligations;
  final List<VehicleEvent> events;
  final ValueChanged<RecurringObligation> onObligationSaved;
  final void Function(
    RecurringObligation obligation,
    double amount,
    DateTime paidAt,
    String? notes,
  )
  onObligationPaid;
  final ValueChanged<VehicleEvent> onEventSaved;
  final ValueChanged<VehicleEvent> onEventDeleted;

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
              const SectionHeader(title: 'Registo rápido'),
              const SizedBox(height: 6),
              QuickActions(
                vehicle: _selectedVehicle,
                obligations: widget.obligations,
                onObligationSaved: widget.onObligationSaved,
                onEventSaved: widget.onEventSaved,
              ),
              const SizedBox(height: 24),
              const SectionHeader(title: 'Próximos compromissos'),
              const SizedBox(height: 12),
              UpcomingCard(
                title: 'Inspeção periódica',
                date: _selectedVehicle.nextInspection,
                icon: Icons.fact_check_rounded,
                color: AppColors.warning,
                caption: _selectedVehicle.licensePlate,
              ),
              const SizedBox(height: 10),
              for (final obligation in vehicleObligations) ...[
                const SizedBox(height: 10),
                ObligationReminderCard(
                  obligation: obligation,
                  onPaid: () => _markAsPaid(context, obligation),
                  onEdit: () => _editObligation(context, obligation),
                ),
              ],
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Atividade recente',
                actionLabel: 'Ver tudo',
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: vehicleEvents.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(22),
                          child: Text('Ainda não existem registos.'),
                        )
                      : Column(
                          children: [
                            for (var i = 0; i < vehicleEvents.length; i++)
                              EventTile(
                                event: vehicleEvents[i],
                                showDivider: i < vehicleEvents.length - 1,
                                onEdit: () => EventActions.edit(
                                  context,
                                  vehicleEvents[i],
                                  widget.onEventSaved,
                                ),
                                onDelete: () => EventActions.delete(
                                  context,
                                  vehicleEvents[i],
                                  widget.onEventDeleted,
                                  widget.onEventSaved,
                                ),
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

  void _editObligation(BuildContext context, RecurringObligation obligation) {
    ObligationSetupSheet.show(
      context: context,
      vehicle: _selectedVehicle,
      type: obligation.type,
      existing: obligation,
      onSave: widget.onObligationSaved,
    );
  }

  Future<void> _markAsPaid(
    BuildContext context,
    RecurringObligation obligation,
  ) async {
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$type pago. Próximo aviso: ${next.nextDueDate.month}/${next.nextDueDate.year}.',
        ),
      ),
    );
  }
}
