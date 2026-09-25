import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';

class InspectionCompletion {
  const InspectionCompletion({
    required this.completedAt,
    required this.nextInspection,
    required this.result,
    required this.amount,
    this.notes,
  });

  final DateTime completedAt;
  final DateTime nextInspection;
  final String result;
  final double amount;
  final String? notes;
}

class InspectionCompletionSheet extends StatefulWidget {
  const InspectionCompletionSheet({super.key});

  static Future<InspectionCompletion?> show(BuildContext context) {
    return showModalBottomSheet<InspectionCompletion>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const InspectionCompletionSheet(),
    );
  }

  @override
  State<InspectionCompletionSheet> createState() =>
      _InspectionCompletionSheetState();
}

class _InspectionCompletionSheetState extends State<InspectionCompletionSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _notes = TextEditingController();
  DateTime _completedAt = DateTime.now();
  late DateTime _nextInspection = DateTime(
    _completedAt.year + 1,
    _completedAt.month,
    _completedAt.day,
  );
  String _result = 'Aprovado';

  @override
  void dispose() {
    _amount.dispose();
    _notes.dispose();
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
              Text(
                'Registar inspeção',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              Text(
                'Confirme o resultado e a data indicada para a próxima inspeção.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: _result,
                borderRadius: BorderRadius.circular(18),
                decoration: const InputDecoration(
                  labelText: 'Resultado',
                  prefixIcon: Icon(Icons.fact_check_rounded),
                ),
                items: const [
                  DropdownMenuItem(value: 'Aprovado', child: Text('Aprovado')),
                  DropdownMenuItem(
                    value: 'Aprovado com anotações',
                    child: Text('Aprovado com anotações'),
                  ),
                  DropdownMenuItem(
                    value: 'Reprovado',
                    child: Text('Reprovado'),
                  ),
                ],
                onChanged: (value) => setState(() => _result = value!),
              ),
              const SizedBox(height: 12),
              _DateField(
                label: 'Data da inspeção',
                value: _completedAt,
                onTap: () => _selectDate(isNext: false),
              ),
              const SizedBox(height: 12),
              _DateField(
                label: 'Próxima inspeção',
                value: _nextInspection,
                onTap: () => _selectDate(isNext: true),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amount,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Valor pago',
                  prefixIcon: Icon(Icons.euro_rounded),
                ),
                validator: (value) {
                  final parsed = double.tryParse(
                    (value ?? '').replaceAll(',', '.'),
                  );
                  return parsed == null || parsed <= 0
                      ? 'Indique o valor pago'
                      : null;
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _notes,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Notas (opcional)',
                  prefixIcon: Icon(Icons.notes_rounded),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: const Text('Guardar inspeção'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate({required bool isNext}) async {
    final current = isNext ? _nextInspection : _completedAt;
    final date = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (date == null) return;
    setState(() {
      if (isNext) {
        _nextInspection = date;
      } else {
        _completedAt = date;
      }
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      InspectionCompletion(
        completedAt: _completedAt,
        nextInspection: _nextInspection,
        result: _result,
        amount: double.parse(_amount.text.replaceAll(',', '.')),
        notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final DateTime value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today_rounded),
        ),
        child: Text(Formatters.fullDate(value)),
      ),
    );
  }
}
