import 'package:flutter/material.dart';

import '../../../core/models/vehicle_event.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_modal.dart';
import '../../../shared/widgets/app_notes.dart';

class EventEditSheet extends StatefulWidget {
  const EventEditSheet({super.key, required this.event});

  final VehicleEvent event;

  static Future<VehicleEvent?> show(BuildContext context, VehicleEvent event) {
    return showAppModal<VehicleEvent>(
      context: context,
      builder: (_) => EventEditSheet(event: event),
    );
  }

  @override
  State<EventEditSheet> createState() => _EventEditSheetState();
}

class _EventEditSheetState extends State<EventEditSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  late final TextEditingController _notesController;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.title);
    _amountController = TextEditingController(
      text: widget.event.amount?.toStringAsFixed(2).replaceAll('.', ',') ?? '',
    );
    _notesController = TextEditingController(text: widget.event.notes ?? '');
    _date = widget.event.date;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Editar registo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.edit_rounded),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Indique uma descrição'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  prefixIcon: Icon(Icons.euro_rounded),
                ),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return null;
                  final amount = double.tryParse(text.replaceAll(',', '.'));
                  if (amount == null || !amount.isFinite) {
                    return 'Indique um valor válido';
                  }
                  return amount < 0 ? 'O valor não pode ser negativo' : null;
                },
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: _selectDate,
                borderRadius: BorderRadius.circular(16),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Data',
                    prefixIcon: Icon(Icons.calendar_today_rounded),
                  ),
                  child: Text(Formatters.fullDate(_date)),
                ),
              ),
              const SizedBox(height: 12),
              AppNotesField(controller: _notesController),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: const Text('Guardar alterações'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) setState(() => _date = date);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final title = _titleController.text.trim();
    Navigator.pop(
      context,
      widget.event.copyWith(
        title: title,
        date: _date,
        amount: double.tryParse(_amountController.text.replaceAll(',', '.')),
        notes: _notesController.text.trim(),
      ),
    );
  }
}
