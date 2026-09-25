import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/vehicle.dart';
import '../../../core/utils/formatters.dart';

class MileageUpdateSheet extends StatefulWidget {
  const MileageUpdateSheet({super.key, required this.vehicle});

  final Vehicle vehicle;

  static Future<Vehicle?> show(BuildContext context, Vehicle vehicle) {
    return showModalBottomSheet<Vehicle>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => MileageUpdateSheet(vehicle: vehicle),
    );
  }

  @override
  State<MileageUpdateSheet> createState() => _MileageUpdateSheetState();
}

class _MileageUpdateSheetState extends State<MileageUpdateSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _mileageController;

  @override
  void initState() {
    super.initState();
    _mileageController = TextEditingController();
  }

  @override
  void dispose() {
    _mileageController.dispose();
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
              'Atualizar quilometragem',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            Text(
              '${widget.vehicle.displayName} · Atual: ${Formatters.kilometers(widget.vehicle.mileage)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _mileageController,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nova quilometragem',
                hintText: 'Ex.: 128500',
                suffixText: 'km',
                prefixIcon: Icon(Icons.speed_rounded),
              ),
              validator: (value) {
                final mileage = int.tryParse(value?.trim() ?? '');
                if (mileage == null) {
                  return 'Indique a quilometragem em números inteiros';
                }
                if (mileage < widget.vehicle.mileage) {
                  return 'Não pode ser inferior à quilometragem atual';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            Text(
              'Para corrigir um valor anterior, utilize “Editar veículo”.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: const Text('Atualizar quilometragem'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      widget.vehicle.copyWith(
        mileage: int.parse(_mileageController.text.trim()),
      ),
    );
  }
}
