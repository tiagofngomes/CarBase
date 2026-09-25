import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/record_type.dart';
import '../../../core/models/vehicle.dart';
import '../../../core/models/vehicle_event.dart';

class RecordEntrySheet extends StatefulWidget {
  const RecordEntrySheet({
    super.key,
    required this.type,
    required this.vehicle,
    required this.onSave,
  });

  final RecordType type;
  final Vehicle vehicle;
  final ValueChanged<VehicleEvent> onSave;

  static Future<void> show(
    BuildContext context,
    RecordType type,
    Vehicle vehicle,
    ValueChanged<VehicleEvent> onSave,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) =>
          RecordEntrySheet(type: type, vehicle: vehicle, onSave: onSave),
    );
  }

  @override
  State<RecordEntrySheet> createState() => _RecordEntrySheetState();
}

class _RecordEntrySheetState extends State<RecordEntrySheet> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (final field in _fieldsFor(widget.type))
        field.label: TextEditingController(),
    };
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fields = _fieldsFor(widget.type);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        24 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _color.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(widget.type.icon, color: _color),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Registar ${widget.type.label.toLowerCase()}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          _description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(widget.vehicle.type.icon, color: AppColors.blue),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.vehicle.displayName,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${widget.vehicle.licensePlate} · ${widget.vehicle.associationLabel}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.lock_rounded,
                      size: 17,
                      color: AppColors.muted,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              for (final field in fields) ...[
                TextFormField(
                  controller: _controllers[field.label],
                  decoration: InputDecoration(
                    labelText: field.label,
                    hintText: field.hint,
                    prefixIcon: field.date
                        ? IconButton(
                            onPressed: () => _selectDate(field.label),
                            tooltip: 'Escolher data',
                            icon: Icon(field.icon),
                          )
                        : Icon(field.icon),
                  ),
                  keyboardType: field.numeric
                      ? const TextInputType.numberWithOptions(decimal: true)
                      : TextInputType.text,
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (field.required && text.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (field.date &&
                        text.isNotEmpty &&
                        _parseDate(text) == null) {
                      return 'Indique uma data válida';
                    }
                    if (field.date && text.isNotEmpty) {
                      final date = _parseDate(text)!;
                      final today = DateTime.now();
                      if (field.label == 'Data' &&
                          date.isAfter(
                            DateTime(today.year, today.month, today.day),
                          )) {
                        return 'A data não pode ser futura';
                      }
                      if (field.label == 'Próxima manutenção (opcional)') {
                        final recordDate = _parseDate(_value('Data'));
                        if (recordDate != null && !date.isAfter(recordDate)) {
                          return 'Deve ser posterior à manutenção';
                        }
                      }
                    }
                    if (field.numeric && text.isNotEmpty) {
                      final number = double.tryParse(text.replaceAll(',', '.'));
                      if (number == null || !number.isFinite) {
                        return 'Indique um número válido';
                      }
                      if (number < 0) return 'O valor não pode ser negativo';
                      if (field.wholeNumber &&
                          number != number.roundToDouble()) {
                        return 'Indique um número inteiro';
                      }
                      if (field.label == 'Ano fiscal' &&
                          (number < 2000 || number > DateTime.now().year + 1)) {
                        return 'Indique um ano válido';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
              ],
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notas (opcional)',
                  prefixIcon: Icon(Icons.notes_rounded),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.attach_file_rounded),
                label: const Text('Anexar comprovativo'),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: const Text('Guardar registo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color get _color => switch (widget.type) {
    RecordType.maintenance => AppColors.warning,
    RecordType.iuc => AppColors.navy,
    RecordType.insurance => AppColors.blue,
    RecordType.otherExpense => AppColors.success,
    RecordType.inspection => AppColors.brightBlue,
  };

  String get _description => switch (widget.type) {
    RecordType.maintenance => 'Histórico, custo e próxima intervenção.',
    RecordType.iuc => 'Pagamento e prazo do imposto anual.',
    RecordType.insurance => 'Apólice, cobertura e data de renovação.',
    RecordType.otherExpense => 'Um custo adicional associado ao veículo.',
    RecordType.inspection => 'Resultado e validade da inspeção.',
  };

  List<_FieldDefinition> _fieldsFor(RecordType type) => switch (type) {
    RecordType.maintenance => const [
      _FieldDefinition(
        'Serviço realizado',
        Icons.build_circle_outlined,
        hint: 'Ex.: mudança de óleo',
      ),
      _FieldDefinition('Oficina', Icons.store_rounded),
      _FieldDefinition(
        'Data',
        Icons.calendar_today_rounded,
        hint: 'DD/MM/AAAA',
        date: true,
      ),
      _FieldDefinition(
        'Quilometragem',
        Icons.speed_rounded,
        numeric: true,
        wholeNumber: true,
      ),
      _FieldDefinition('Custo', Icons.euro_rounded, numeric: true),
      _FieldDefinition(
        'Próxima manutenção (opcional)',
        Icons.event_repeat_rounded,
        required: false,
        date: true,
      ),
    ],
    RecordType.iuc => const [
      _FieldDefinition(
        'Ano fiscal',
        Icons.calendar_month_rounded,
        numeric: true,
        wholeNumber: true,
      ),
      _FieldDefinition(
        'Estado',
        Icons.task_alt_rounded,
        hint: 'Pendente ou pago',
      ),
      _FieldDefinition(
        'Prazo de pagamento',
        Icons.event_rounded,
        hint: 'DD/MM/AAAA',
        date: true,
      ),
      _FieldDefinition(
        'Data de pagamento',
        Icons.event_available_rounded,
        hint: 'DD/MM/AAAA',
        required: false,
        date: true,
      ),
      _FieldDefinition('Valor', Icons.euro_rounded, numeric: true),
    ],
    RecordType.insurance => const [
      _FieldDefinition('Seguradora', Icons.business_rounded),
      _FieldDefinition('Número da apólice', Icons.numbers_rounded),
      _FieldDefinition(
        'Tipo de cobertura',
        Icons.verified_user_rounded,
        hint: 'Ex.: todos os riscos',
      ),
      _FieldDefinition('Prémio anual', Icons.euro_rounded, numeric: true),
      _FieldDefinition(
        'Periodicidade',
        Icons.autorenew_rounded,
        hint: 'Mensal, semestral ou anual',
      ),
      _FieldDefinition(
        'Data de renovação',
        Icons.event_repeat_rounded,
        hint: 'DD/MM/AAAA',
        date: true,
      ),
    ],
    RecordType.otherExpense => const [
      _FieldDefinition('Descrição', Icons.edit_rounded),
      _FieldDefinition(
        'Categoria',
        Icons.category_rounded,
        hint: 'Ex.: estacionamento, portagens',
      ),
      _FieldDefinition(
        'Fornecedor (opcional)',
        Icons.storefront_rounded,
        required: false,
      ),
      _FieldDefinition(
        'Data',
        Icons.calendar_today_rounded,
        hint: 'DD/MM/AAAA',
        date: true,
      ),
      _FieldDefinition('Valor', Icons.euro_rounded, numeric: true),
    ],
    RecordType.inspection => const [
      _FieldDefinition('Data', Icons.calendar_today_rounded, date: true),
      _FieldDefinition('Resultado', Icons.fact_check_rounded),
      _FieldDefinition('Validade', Icons.event_rounded, date: true),
      _FieldDefinition('Valor', Icons.euro_rounded, numeric: true),
    ],
  };

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final isMaintenance = widget.type == RecordType.maintenance;
    final title = _value(isMaintenance ? 'Serviço realizado' : 'Descrição');
    final subtitle = isMaintenance
        ? '${_value('Oficina')} · ${_value('Quilometragem')} km'
        : '${_value('Categoria')} · ${_value('Fornecedor (opcional)')}'
              .replaceAll(RegExp(r' · $'), '');
    final amount = double.tryParse(
      _value(isMaintenance ? 'Custo' : 'Valor').replaceAll(',', '.'),
    );
    final date = _parseDate(_value('Data')) ?? DateTime.now();
    widget.onSave(
      VehicleEvent(
        id: 'record-${DateTime.now().microsecondsSinceEpoch}',
        vehicleId: widget.vehicle.id,
        title: title,
        subtitle: subtitle,
        date: date,
        type: widget.type,
        amount: amount,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      ),
    );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.type.label} registado com sucesso.')),
    );
  }

  String _value(String label) => _controllers[label]?.text.trim() ?? '';

  Future<void> _selectDate(String label) async {
    final controller = _controllers[label];
    if (controller == null) return;
    final now = DateTime.now();
    final current = _parseDate(controller.text) ?? now;
    final selected = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 10, 12, 31),
    );
    if (selected == null) return;
    controller.text =
        '${selected.day.toString().padLeft(2, '0')}/'
        '${selected.month.toString().padLeft(2, '0')}/'
        '${selected.year}';
  }

  DateTime? _parseDate(String value) {
    final parts = value.split('/');
    if (parts.length != 3) return null;
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;
    final parsed = DateTime(year, month, day);
    if (parsed.year != year || parsed.month != month || parsed.day != day) {
      return null;
    }
    return parsed;
  }
}

class _FieldDefinition {
  const _FieldDefinition(
    this.label,
    this.icon, {
    this.hint,
    this.numeric = false,
    this.required = true,
    this.date = false,
    this.wholeNumber = false,
  });

  final String label;
  final IconData icon;
  final String? hint;
  final bool numeric;
  final bool required;
  final bool date;
  final bool wholeNumber;
}
