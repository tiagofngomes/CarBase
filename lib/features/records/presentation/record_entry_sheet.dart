import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/record_type.dart';
import '../../../data/demo_data.dart';

class RecordEntrySheet extends StatefulWidget {
  const RecordEntrySheet({super.key, required this.type});

  final RecordType type;

  static Future<void> show(BuildContext context, RecordType type) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => RecordEntrySheet(type: type),
    );
  }

  @override
  State<RecordEntrySheet> createState() => _RecordEntrySheetState();
}

class _RecordEntrySheetState extends State<RecordEntrySheet> {
  final _formKey = GlobalKey<FormState>();

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
              DropdownButtonFormField<String>(
                initialValue: DemoData.vehicles.first.id,
                decoration: const InputDecoration(
                  labelText: 'Veículo',
                  prefixIcon: Icon(Icons.directions_car_rounded),
                ),
                items: DemoData.vehicles
                    .map(
                      (vehicle) => DropdownMenuItem(
                        value: vehicle.id,
                        child: Text(
                          '${vehicle.displayName} · ${vehicle.licensePlate}',
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (_) {},
              ),
              const SizedBox(height: 12),
              for (final field in fields) ...[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: field.label,
                    hintText: field.hint,
                    prefixIcon: Icon(field.icon),
                  ),
                  keyboardType: field.numeric
                      ? const TextInputType.numberWithOptions(decimal: true)
                      : TextInputType.text,
                  validator: field.required
                      ? (value) => value == null || value.trim().isEmpty
                            ? 'Campo obrigatório'
                            : null
                      : null,
                ),
                const SizedBox(height: 12),
              ],
              TextFormField(
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
      ),
      _FieldDefinition('Quilometragem', Icons.speed_rounded, numeric: true),
      _FieldDefinition('Custo', Icons.euro_rounded, numeric: true),
      _FieldDefinition(
        'Próxima manutenção (opcional)',
        Icons.event_repeat_rounded,
        required: false,
      ),
    ],
    RecordType.iuc => const [
      _FieldDefinition(
        'Ano fiscal',
        Icons.calendar_month_rounded,
        numeric: true,
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
      ),
      _FieldDefinition(
        'Data de pagamento',
        Icons.event_available_rounded,
        hint: 'DD/MM/AAAA',
        required: false,
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
      ),
      _FieldDefinition('Valor', Icons.euro_rounded, numeric: true),
    ],
    RecordType.inspection => const [
      _FieldDefinition('Data', Icons.calendar_today_rounded),
      _FieldDefinition('Resultado', Icons.fact_check_rounded),
      _FieldDefinition('Validade', Icons.event_rounded),
      _FieldDefinition('Valor', Icons.euro_rounded, numeric: true),
    ],
  };

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.type.label} registado com sucesso.')),
    );
  }
}

class _FieldDefinition {
  const _FieldDefinition(
    this.label,
    this.icon, {
    this.hint,
    this.numeric = false,
    this.required = true,
  });

  final String label;
  final IconData icon;
  final String? hint;
  final bool numeric;
  final bool required;
}
