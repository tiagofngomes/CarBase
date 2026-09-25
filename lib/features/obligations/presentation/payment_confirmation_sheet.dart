import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/record_type.dart';
import '../../../core/models/recurring_obligation.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_modal.dart';
import '../../../shared/widgets/app_notes.dart';

class PaymentConfirmation {
  const PaymentConfirmation({
    required this.amount,
    required this.paidAt,
    this.notes,
  });

  final double amount;
  final DateTime paidAt;
  final String? notes;
}

class PaymentConfirmationSheet extends StatefulWidget {
  const PaymentConfirmationSheet({super.key, required this.obligation});

  final RecurringObligation obligation;

  static Future<PaymentConfirmation?> show(
    BuildContext context,
    RecurringObligation obligation,
  ) {
    return showAppModal<PaymentConfirmation>(
      context: context,
      builder: (_) => PaymentConfirmationSheet(obligation: obligation),
    );
  }

  @override
  State<PaymentConfirmationSheet> createState() =>
      _PaymentConfirmationSheetState();
}

class _PaymentConfirmationSheetState extends State<PaymentConfirmationSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _paidAt = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.obligation.type == RecordType.iuc ? 'IUC' : 'seguro';
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
                'Marcar $label como pago',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              Text(
                'O pagamento fica guardado no histórico do veículo.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Valor pago',
                  hintText: '0,00',
                  prefixIcon: Icon(Icons.euro_rounded),
                ),
                validator: (value) {
                  final amount = double.tryParse(
                    (value ?? '').replaceAll(',', '.'),
                  );
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
                    labelText: 'Data de pagamento',
                    prefixIcon: Icon(Icons.event_available_rounded),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text(Formatters.fullDate(_paidAt))),
                      const Text(
                        'Alterar',
                        style: TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Se não alterar, é assumida a data de hoje.',
                style: TextStyle(fontSize: 11, color: AppColors.muted),
              ),
              const SizedBox(height: 12),
              AppNotesField(controller: _notesController),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _confirm,
                  child: const Text('Confirmar pagamento'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _paidAt,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (selected != null) setState(() => _paidAt = selected);
  }

  void _confirm() {
    if (!_formKey.currentState!.validate()) return;
    final amount = double.parse(_amountController.text.replaceAll(',', '.'));
    Navigator.pop(
      context,
      PaymentConfirmation(
        amount: amount,
        paidAt: _paidAt,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      ),
    );
  }
}
