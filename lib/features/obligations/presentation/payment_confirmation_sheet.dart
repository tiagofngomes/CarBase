import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/record_type.dart';
import '../../../core/models/recurring_obligation.dart';
import '../../../core/utils/formatters.dart';

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
    return showModalBottomSheet<PaymentConfirmation>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
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
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        24 + MediaQuery.viewInsetsOf(context).bottom,
      ),
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
                return amount == null || amount <= 0
                    ? 'Indique o valor pago'
                    : null;
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
            TextField(
              controller: _notesController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Notas (opcional)',
                hintText: 'Acrescente alguma informação relevante',
                prefixIcon: Icon(Icons.notes_rounded),
              ),
            ),
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
