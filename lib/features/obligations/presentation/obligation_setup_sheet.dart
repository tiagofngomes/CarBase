import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/record_type.dart';
import '../../../core/models/recurring_obligation.dart';
import '../../../core/models/vehicle.dart';

class ObligationSetupSheet extends StatefulWidget {
  const ObligationSetupSheet({
    super.key,
    required this.vehicle,
    required this.type,
    required this.onSave,
    this.existing,
  });

  final Vehicle vehicle;
  final RecordType type;
  final RecurringObligation? existing;
  final ValueChanged<RecurringObligation> onSave;

  static Future<void> show({
    required BuildContext context,
    required Vehicle vehicle,
    required RecordType type,
    required ValueChanged<RecurringObligation> onSave,
    RecurringObligation? existing,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ObligationSetupSheet(
        vehicle: vehicle,
        type: type,
        existing: existing,
        onSave: onSave,
      ),
    );
  }

  @override
  State<ObligationSetupSheet> createState() => _ObligationSetupSheetState();
}

class _ObligationSetupSheetState extends State<ObligationSetupSheet> {
  static const _months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  late int _month;
  late bool _hasExactDay;
  late PaymentFrequency _frequency;
  late bool _remindMonthBefore;
  late bool _remindDueMonth;
  late final TextEditingController _dayController;
  late final TextEditingController _providerController;

  bool get _isIuc => widget.type == RecordType.iuc;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _month = existing?.nextDueDate.month ?? DateTime.now().month;
    _hasExactDay = existing?.hasExactDay ?? false;
    _frequency = _isIuc
        ? PaymentFrequency.annual
        : existing?.frequency ?? PaymentFrequency.annual;
    _remindMonthBefore = existing?.remindMonthBefore ?? true;
    _remindDueMonth = existing?.remindDueMonth ?? true;
    _dayController = TextEditingController(
      text: existing?.hasExactDay == true
          ? existing!.nextDueDate.day.toString()
          : '',
    );
    _providerController = TextEditingController(text: existing?.provider ?? '');
  }

  @override
  void dispose() {
    _dayController.dispose();
    _providerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        24 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              widget.existing == null
                  ? 'Configurar ${widget.type.label}'
                  : 'Editar avisos de ${widget.type.label}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            Text(
              '${widget.vehicle.displayName} · ${widget.vehicle.licensePlate}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 22),
            if (!_isIuc) ...[
              DropdownButtonFormField<PaymentFrequency>(
                initialValue: _frequency,
                decoration: const InputDecoration(
                  labelText: 'Periodicidade',
                  prefixIcon: Icon(Icons.autorenew_rounded),
                ),
                items: PaymentFrequency.values
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.label),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _frequency = value!),
              ),
              const SizedBox(height: 12),
            ],
            DropdownButtonFormField<int>(
              initialValue: _month,
              decoration: InputDecoration(
                labelText: _isIuc ? 'Mês do IUC' : 'Mês do próximo pagamento',
                prefixIcon: const Icon(Icons.calendar_month_rounded),
              ),
              items: [
                for (var i = 0; i < _months.length; i++)
                  DropdownMenuItem(value: i + 1, child: Text(_months[i])),
              ],
              onChanged: (value) => setState(() => _month = value!),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Sei o dia exato'),
              subtitle: const Text(
                'Opcional — o mês é suficiente para criar avisos',
              ),
              value: _hasExactDay,
              onChanged: (value) => setState(() => _hasExactDay = value),
            ),
            if (_hasExactDay) ...[
              TextField(
                controller: _dayController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Dia',
                  hintText: '1 a 31',
                  prefixIcon: Icon(Icons.today_rounded),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Card(
              color: AppColors.blue.withValues(alpha: .06),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.notifications_active_rounded,
                          color: AppColors.blue,
                          size: 21,
                        ),
                        SizedBox(width: 9),
                        Text(
                          'Avisos',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text('Um mês antes'),
                      value: _remindMonthBefore,
                      onChanged: (value) =>
                          setState(() => _remindMonthBefore = value!),
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text('No próprio mês'),
                      value: _remindDueMonth,
                      onChanged: (value) =>
                          setState(() => _remindDueMonth = value!),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: const Text('Detalhes opcionais'),
              children: [
                if (!_isIuc) ...[
                  TextField(
                    controller: _providerController,
                    decoration: const InputDecoration(
                      labelText: 'Seguradora',
                      prefixIcon: Icon(Icons.business_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (_isIuc)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      'O valor será pedido apenas quando registar o pagamento.',
                      style: TextStyle(color: AppColors.muted, fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: Text(
                  widget.existing == null
                      ? 'Ativar avisos'
                      : 'Guardar alterações',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    final now = DateTime.now();
    final enteredDay = int.tryParse(_dayController.text);
    final day = _hasExactDay ? (enteredDay ?? 1).clamp(1, 28) : 1;
    var year = now.year;
    var dueDate = DateTime(year, _month, day);
    if (dueDate.isBefore(DateTime(now.year, now.month, now.day))) {
      year++;
      dueDate = DateTime(year, _month, day);
    }

    widget.onSave(
      RecurringObligation(
        id: widget.existing?.id ?? '${widget.vehicle.id}-${widget.type.name}',
        vehicleId: widget.vehicle.id,
        type: widget.type,
        frequency: _frequency,
        nextDueDate: dueDate,
        hasExactDay: _hasExactDay,
        provider: _providerController.text.trim().isEmpty
            ? null
            : _providerController.text.trim(),
        remindMonthBefore: _remindMonthBefore,
        remindDueMonth: _remindDueMonth,
      ),
    );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Avisos de ${widget.type.label} atualizados.')),
    );
  }
}
