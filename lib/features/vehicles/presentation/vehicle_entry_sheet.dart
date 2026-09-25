import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/vehicle.dart';
import '../../../core/utils/formatters.dart';

class VehicleEntrySheet extends StatefulWidget {
  const VehicleEntrySheet({super.key});

  static Future<Vehicle?> show(BuildContext context) {
    return showModalBottomSheet<Vehicle>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const VehicleEntrySheet(),
    );
  }

  @override
  State<VehicleEntrySheet> createState() => _VehicleEntrySheetState();
}

class _VehicleEntrySheetState extends State<VehicleEntrySheet> {
  final _formKey = GlobalKey<FormState>();
  final _make = TextEditingController();
  final _model = TextEditingController();
  final _plate = TextEditingController();
  final _person = TextEditingController();
  final _mileage = TextEditingController();
  final _year = TextEditingController();
  late DateTime _inspection = DateTime.now().add(const Duration(days: 365));

  @override
  void dispose() {
    _make.dispose();
    _model.dispose();
    _plate.dispose();
    _person.dispose();
    _mileage.dispose();
    _year.dispose();
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
                'Adicionar veículo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _field(_make, 'Marca')),
                  const SizedBox(width: 10),
                  Expanded(child: _field(_model, 'Modelo')),
                ],
              ),
              const SizedBox(height: 12),
              _field(_plate, 'Matrícula', icon: Icons.pin_rounded),
              const SizedBox(height: 12),
              _field(
                _person,
                'Associado a',
                icon: Icons.person_rounded,
                required: false,
                hint: 'Ex.: Miguel, Ana, filho',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _field(
                      _year,
                      'Ano',
                      numeric: true,
                      icon: Icons.calendar_month_rounded,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _field(
                      _mileage,
                      'Quilometragem',
                      numeric: true,
                      icon: Icons.speed_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: _selectInspection,
                borderRadius: BorderRadius.circular(16),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Próxima inspeção',
                    prefixIcon: Icon(Icons.fact_check_rounded),
                  ),
                  child: Text(Formatters.fullDate(_inspection)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: const Text('Adicionar à garagem'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    IconData? icon,
    bool numeric = false,
    bool required = true,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: numeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon == null ? null : Icon(icon),
      ),
      validator: required
          ? (value) => value == null || value.trim().isEmpty
                ? 'Campo obrigatório'
                : null
          : null,
    );
  }

  Future<void> _selectInspection() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _inspection,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (date != null) setState(() => _inspection = date);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      Vehicle(
        id: 'vehicle-${DateTime.now().microsecondsSinceEpoch}',
        make: _make.text.trim(),
        model: _model.text.trim(),
        year: int.tryParse(_year.text) ?? DateTime.now().year,
        licensePlate: _plate.text.trim().toUpperCase(),
        mileage: int.tryParse(_mileage.text) ?? 0,
        nextInspection: _inspection,
        color: AppColors.navy.toARGB32(),
        associatedPerson: _person.text.trim().isEmpty
            ? null
            : _person.text.trim(),
      ),
    );
  }
}
