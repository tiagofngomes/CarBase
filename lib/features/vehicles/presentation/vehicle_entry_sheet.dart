import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/vehicle.dart';

class VehicleEntrySheet extends StatefulWidget {
  const VehicleEntrySheet({super.key, this.existing});

  final Vehicle? existing;

  static Future<Vehicle?> show(BuildContext context, {Vehicle? existing}) {
    return showModalBottomSheet<Vehicle>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => VehicleEntrySheet(existing: existing),
    );
  }

  @override
  State<VehicleEntrySheet> createState() => _VehicleEntrySheetState();
}

class _VehicleEntrySheetState extends State<VehicleEntrySheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _make;
  late final TextEditingController _model;
  late final TextEditingController _plate;
  late final TextEditingController _person;
  late final TextEditingController _mileage;
  late final TextEditingController _year;
  late VehicleType _type;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final vehicle = widget.existing;
    _make = TextEditingController(text: vehicle?.make ?? '');
    _model = TextEditingController(text: vehicle?.model ?? '');
    _plate = TextEditingController(text: vehicle?.licensePlate ?? '');
    _person = TextEditingController(text: vehicle?.associatedPerson ?? '');
    _mileage = TextEditingController(text: vehicle?.mileage.toString() ?? '');
    _year = TextEditingController(text: vehicle?.year.toString() ?? '');
    _type = vehicle?.type ?? VehicleType.car;
  }

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
                _isEditing ? 'Editar veículo' : 'Adicionar veículo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (_isEditing) ...[
                const SizedBox(height: 5),
                Text(
                  'Atualize os dados e a quilometragem atual.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 20),
              DropdownButtonFormField<VehicleType>(
                initialValue: _type,
                borderRadius: BorderRadius.circular(18),
                decoration: const InputDecoration(
                  labelText: 'Tipo de veículo',
                  prefixIcon: Icon(Icons.category_rounded),
                ),
                items: VehicleType.values
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Row(
                          children: [
                            Icon(type.icon, size: 20),
                            const SizedBox(width: 10),
                            Text(type.label),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _type = value!),
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: Text(
                    _isEditing ? 'Guardar alterações' : 'Adicionar à garagem',
                  ),
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
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Campo obrigatório';
              }
              if (numeric && int.tryParse(value.trim()) == null) {
                return 'Indique um número válido';
              }
              if (label == 'Ano') {
                final year = int.parse(value.trim());
                if (year < 1886 || year > DateTime.now().year + 1) {
                  return 'Indique um ano válido';
                }
              }
              if (label == 'Quilometragem' && int.parse(value.trim()) < 0) {
                return 'Não pode ser negativa';
              }
              return null;
            }
          : null,
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      Vehicle(
        id:
            widget.existing?.id ??
            'vehicle-${DateTime.now().microsecondsSinceEpoch}',
        make: _make.text.trim(),
        model: _model.text.trim(),
        year: int.tryParse(_year.text) ?? DateTime.now().year,
        licensePlate: _plate.text.trim().toUpperCase(),
        mileage: int.tryParse(_mileage.text) ?? 0,
        nextInspection:
            widget.existing?.nextInspection ??
            DateTime.now().add(const Duration(days: 365)),
        color: widget.existing?.color ?? AppColors.navy.toARGB32(),
        associatedPerson: _person.text.trim().isEmpty
            ? null
            : _person.text.trim(),
        type: _type,
      ),
    );
  }
}
