import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/record_type.dart';
import '../../../core/models/recurring_obligation.dart';
import '../../../core/models/vehicle.dart';
import '../../../shared/widgets/app_modal.dart';
import '../../../shared/widgets/app_notice.dart';
import '../../../shared/widgets/app_notes.dart';

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
    return showAppModal<void>(
      context: context,
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
  bool _showAdditionalInfo = false;
  String? _dayError;
  late final TextEditingController _dayController;
  late final TextEditingController _providerController;
  late final TextEditingController _notesController;

  bool get _isIuc => widget.type == RecordType.iuc;
  bool get _isInspection => widget.type == RecordType.inspection;

  String get _dayLabel => _isIuc
      ? 'Dia do IUC'
      : _isInspection
      ? 'Dia da próxima inspeção'
      : 'Dia do próximo pagamento';

  String get _monthLabel => _isIuc
      ? 'Mês do IUC'
      : _isInspection
      ? 'Mês da próxima inspeção'
      : 'Mês do próximo pagamento';

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _month = existing?.nextDueDate.month ?? DateTime.now().month;
    _hasExactDay = existing?.hasExactDay ?? false;
    _frequency = _isIuc || _isInspection
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
    _notesController = TextEditingController(text: existing?.notes ?? '');
  }

  @override
  void dispose() {
    _dayController.dispose();
    _providerController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            if (!_isIuc && !_isInspection) ...[
              DropdownButtonFormField<PaymentFrequency>(
                initialValue: _frequency,
                borderRadius: BorderRadius.circular(18),
                menuMaxHeight: 320,
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
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                title: const Text(
                  'Definir dia específico',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text(
                  'Opcional. Sem um dia definido, os avisos serão apresentados durante o mês selecionado.',
                ),
                value: _hasExactDay,
                onChanged: (value) => setState(() {
                  _hasExactDay = value;
                  _dayError = null;
                }),
              ),
            ),
            const SizedBox(height: 12),
            if (_hasExactDay) ...[
              TextField(
                controller: _dayController,
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  if (_dayError != null) setState(() => _dayError = null);
                },
                decoration: InputDecoration(
                  labelText: _dayLabel,
                  hintText: '1 a 31',
                  prefixIcon: const Icon(Icons.today_rounded),
                  errorText: _dayError,
                ),
              ),
              const SizedBox(height: 12),
            ],
            DropdownButtonFormField<int>(
              initialValue: _month,
              borderRadius: BorderRadius.circular(18),
              menuMaxHeight: 360,
              decoration: InputDecoration(
                labelText: _monthLabel,
                prefixIcon: const Icon(Icons.calendar_month_rounded),
              ),
              items: [
                for (var i = 0; i < _months.length; i++)
                  DropdownMenuItem(value: i + 1, child: Text(_months[i])),
              ],
              onChanged: (value) => setState(() {
                _month = value!;
                _dayError = null;
              }),
            ),
            const SizedBox(height: 12),
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
            if (!_isIuc && !_isInspection) ...[
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => setState(
                        () => _showAdditionalInfo = !_showAdditionalInfo,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.tune_rounded,
                              size: 20,
                              color: AppColors.blue,
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Informação adicional',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Nome da seguradora',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedRotation(
                              turns: _showAdditionalInfo ? .5 : 0,
                              duration: const Duration(milliseconds: 180),
                              child: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_showAdditionalInfo)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                        child: TextField(
                          controller: _providerController,
                          decoration: const InputDecoration(
                            labelText: 'Seguradora',
                            prefixIcon: Icon(Icons.business_rounded),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
            AppNotesField(controller: _notesController),
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
    final lastDay = DateTime(now.year, _month + 1, 0).day;
    if (_hasExactDay &&
        (enteredDay == null || enteredDay < 1 || enteredDay > lastDay)) {
      setState(() => _dayError = 'Indique um dia entre 1 e $lastDay');
      return;
    }
    final day = _hasExactDay ? enteredDay! : 1;
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
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        remindMonthBefore: _remindMonthBefore,
        remindDueMonth: _remindDueMonth,
      ),
    );
    AppNotice.show(context, 'Avisos de ${widget.type.label} atualizados.');
    Navigator.pop(context);
  }
}
