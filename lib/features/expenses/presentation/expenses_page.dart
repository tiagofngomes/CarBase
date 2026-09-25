import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/models/record_type.dart';
import '../../../core/models/vehicle.dart';
import '../../../core/models/vehicle_event.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_modal.dart';
import '../../../shared/widgets/app_notes.dart';
import '../../../shared/widgets/page_header.dart';
import 'widgets/expense_summary.dart';

enum _ExpensePeriod {
  thisMonth('Este mês'),
  last3Months('Últimos 3 meses'),
  thisYear('Este ano');

  const _ExpensePeriod(this.label);
  final String label;
}

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key, required this.events, required this.vehicles});

  final List<VehicleEvent> events;
  final List<Vehicle> vehicles;

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  String? _vehicleId;
  _ExpensePeriod _period = _ExpensePeriod.thisYear;
  DateTime? _selectedMonth;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final range = _rangeFor(now, _period);
    final events = _eventsInRange(range);
    final total = _total(events);
    final months = _monthsInRange(range, events);
    final categoryEvents = _selectedMonth == null
        ? events
        : events
              .where(
                (event) =>
                    event.date.year == _selectedMonth!.year &&
                    event.date.month == _selectedMonth!.month,
              )
              .toList();
    final categoryTotal = _total(categoryEvents);
    final categories = _categories(categoryEvents);
    final comparison = _comparison(now, total);

    return ListView(
      key: const PageStorageKey('expenses'),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
      children: [
        const PageHeader(
          title: 'Despesas',
          subtitle: 'Acompanhe os custos da sua garagem',
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                key: ValueKey(_vehicleId),
                initialValue: _vehicleId ?? 'all',
                borderRadius: BorderRadius.circular(18),
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Veículo',
                  prefixIcon: Icon(Icons.directions_car_outlined),
                ),
                items: [
                  const DropdownMenuItem(value: 'all', child: Text('Todos')),
                  for (final vehicle in widget.vehicles)
                    DropdownMenuItem(
                      value: vehicle.id,
                      child: Text(
                        vehicle.displayName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: (value) => setState(() {
                  _vehicleId = value == 'all' ? null : value;
                  _selectedMonth = null;
                }),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<_ExpensePeriod>(
                initialValue: _period,
                borderRadius: BorderRadius.circular(18),
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Período',
                  prefixIcon: Icon(Icons.date_range_rounded),
                ),
                items: _ExpensePeriod.values
                    .map(
                      (period) => DropdownMenuItem(
                        value: period,
                        child: Text(
                          period.label,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() {
                  _period = value!;
                  _selectedMonth = null;
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        ExpenseSummary(
          total: total,
          periodLabel: _period.label,
          average: months.isEmpty ? 0 : total / months.length,
          recordCount: events.length,
          months: months,
          selectedMonth: _selectedMonth,
          onMonthSelected: (month) => setState(() => _selectedMonth = month),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              _selectedMonth == null
                  ? 'Por categoria'
                  : 'Por categoria · ${_monthName(_selectedMonth!.month)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            Text(
              '${categoryEvents.length} ${categoryEvents.length == 1 ? 'registo' : 'registos'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (categories.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text('Sem despesas registadas neste período.'),
              ),
            ),
          )
        else
          Card(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                children: [
                  for (var i = 0; i < categories.length; i++) ...[
                    _CategoryRow(
                      category: categories[i],
                      total: categoryTotal,
                      onTap: () => _showCategoryDetails(categories[i]),
                    ),
                    if (i < categories.length - 1)
                      const Divider(height: 22, indent: 50),
                  ],
                ],
              ),
            ),
          ),
        if (comparison != null) ...[
          const SizedBox(height: 24),
          _ComparisonCard(comparison: comparison),
        ],
      ],
    );
  }

  List<VehicleEvent> _eventsInRange(_DateRange range) {
    return widget.events.where((event) {
      final amount = event.amount;
      if (amount == null || amount < 0) return false;
      final matchesVehicle =
          _vehicleId == null || event.vehicleId == _vehicleId;
      final matchesDate =
          !event.date.isBefore(range.start) && event.date.isBefore(range.end);
      return matchesVehicle && matchesDate;
    }).toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  List<_ExpenseCategoryData> _categories(List<VehicleEvent> events) {
    return RecordType.values
        .map((type) {
          final matching = events.where((event) => event.type == type).toList();
          return _ExpenseCategoryData(
            type: type,
            events: matching,
            amount: _total(matching),
          );
        })
        .where((category) => category.events.isNotEmpty)
        .toList();
  }

  List<ExpenseMonthData> _monthsInRange(
    _DateRange range,
    List<VehicleEvent> events,
  ) {
    final result = <ExpenseMonthData>[];
    var cursor = DateTime(range.start.year, range.start.month);
    while (cursor.isBefore(range.end)) {
      final amount = events
          .where(
            (event) =>
                event.date.year == cursor.year &&
                event.date.month == cursor.month,
          )
          .fold<double>(0, (sum, event) => sum + event.amount!);
      result.add(ExpenseMonthData(month: cursor, amount: amount));
      cursor = DateTime(cursor.year, cursor.month + 1);
    }
    return result;
  }

  _ExpenseComparison? _comparison(DateTime now, double currentTotal) {
    final previousRange = _previousRangeFor(now, _period);
    final previousEvents = _eventsInRange(previousRange);
    final previousTotal = _total(previousEvents);
    if (previousEvents.isEmpty || previousTotal == 0) return null;
    return _ExpenseComparison(
      percentage: ((currentTotal - previousTotal) / previousTotal * 100),
      previousTotal: previousTotal,
    );
  }

  double _total(List<VehicleEvent> events) =>
      events.fold<double>(0, (sum, event) => sum + (event.amount ?? 0));

  Future<void> _showCategoryDetails(_ExpenseCategoryData category) {
    final height = math.min(
      600.0,
      (145 + category.events.length * 86).toDouble(),
    );
    return showAppModal<void>(
      context: context,
      builder: (dialogContext) => SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _colorFor(category.type).withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      category.type.icon,
                      color: _colorFor(category.type),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _labelFor(category.type),
                          style: Theme.of(dialogContext).textTheme.titleLarge,
                        ),
                        Text(
                          Formatters.currency(category.amount),
                          style: Theme.of(dialogContext).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    tooltip: 'Fechar',
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: category.events.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final event = category.events[index];
                    final vehicle = widget.vehicles.where(
                      (item) => item.id == event.vehicleId,
                    );
                    final vehicleName = vehicle.isEmpty
                        ? 'Veículo'
                        : vehicle.first.displayName;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${Formatters.fullDate(event.date)} · $vehicleName',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                if (event.notes?.isNotEmpty == true) ...[
                                  const SizedBox(height: 4),
                                  AppNotesText(text: event.notes!),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            Formatters.currency(event.amount!),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _monthName(int month) => const [
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
  ][month - 1];

  _DateRange _rangeFor(DateTime now, _ExpensePeriod period) {
    final end = DateTime(now.year, now.month, now.day + 1);
    final start = switch (period) {
      _ExpensePeriod.thisMonth => DateTime(now.year, now.month),
      _ExpensePeriod.last3Months => DateTime(now.year, now.month - 2),
      _ExpensePeriod.thisYear => DateTime(now.year),
    };
    return _DateRange(start, end);
  }

  _DateRange _previousRangeFor(DateTime now, _ExpensePeriod period) {
    return switch (period) {
      _ExpensePeriod.thisMonth => _DateRange(
        DateTime(now.year, now.month - 1),
        DateTime(now.year, now.month),
      ),
      _ExpensePeriod.last3Months => _DateRange(
        DateTime(now.year, now.month - 5),
        DateTime(now.year, now.month - 2),
      ),
      _ExpensePeriod.thisYear => _DateRange(
        DateTime(now.year - 1),
        DateTime(now.year - 1, now.month, now.day + 1),
      ),
    };
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.category,
    required this.total,
    required this.onTap,
  });

  final _ExpenseCategoryData category;
  final double total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(category.type);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(category.type.icon, color: color, size: 21),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _labelFor(category.type),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    total == 0
                        ? '${category.events.length} registos'
                        : '${(category.amount / total * 100).round()}% do total',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Text(
              Formatters.currency(category.amount),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 3),
            const Icon(
              Icons.chevron_right_rounded,
              size: 19,
              color: AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({required this.comparison});

  final _ExpenseComparison comparison;

  @override
  Widget build(BuildContext context) {
    final difference = comparison.percentage;
    final isLower = difference < -.5;
    final isHigher = difference > .5;
    final color = isLower
        ? AppColors.success
        : isHigher
        ? AppColors.warning
        : AppColors.blue;
    final icon = isLower
        ? Icons.trending_down_rounded
        : isHigher
        ? Icons.trending_up_rounded
        : Icons.trending_flat_rounded;
    final title = isLower
        ? '${difference.abs().round()}% abaixo do período anterior'
        : isHigher
        ? '${difference.abs().round()}% acima do período anterior'
        : 'Sem alteração face ao período anterior';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 47,
              height: 47,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Período anterior: ${Formatters.currency(comparison.previousTotal)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateRange {
  const _DateRange(this.start, this.end);
  final DateTime start;
  final DateTime end;
}

class _ExpenseCategoryData {
  const _ExpenseCategoryData({
    required this.type,
    required this.events,
    required this.amount,
  });
  final RecordType type;
  final List<VehicleEvent> events;
  final double amount;
}

class _ExpenseComparison {
  const _ExpenseComparison({
    required this.percentage,
    required this.previousTotal,
  });
  final double percentage;
  final double previousTotal;
}

String _labelFor(RecordType type) => switch (type) {
  RecordType.maintenance => 'Manutenção',
  RecordType.iuc => 'IUC',
  RecordType.insurance => 'Seguro',
  RecordType.otherExpense => 'Outras despesas',
  RecordType.inspection => 'Inspeções',
};

Color _colorFor(RecordType type) => switch (type) {
  RecordType.maintenance => AppColors.warning,
  RecordType.iuc => AppColors.navy,
  RecordType.insurance => AppColors.blue,
  RecordType.otherExpense => AppColors.danger,
  RecordType.inspection => AppColors.success,
};
