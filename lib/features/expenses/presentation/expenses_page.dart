import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/demo_data.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/widgets/section_header.dart';
import 'widgets/expense_summary.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final total = DemoData.expenseCategories.fold<double>(
      0,
      (sum, item) => sum + item.amount,
    );

    return ListView(
      key: const PageStorageKey('expenses'),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
      children: [
        const PageHeader(
          title: 'Despesas',
          subtitle: 'Acompanhe os custos da sua garagem',
        ),
        const SizedBox(height: 22),
        ExpenseSummary(total: total),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Por categoria', actionLabel: 'Este ano'),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              children: [
                for (var i = 0; i < DemoData.expenseCategories.length; i++) ...[
                  _CategoryRow(categoryIndex: i, total: total),
                  if (i < DemoData.expenseCategories.length - 1)
                    const Divider(height: 22, indent: 50),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 47,
                  height: 47,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.trending_down_rounded,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: 13),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '12% abaixo do mês passado',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Boa gestão! Continue assim.',
                        style: TextStyle(color: AppColors.muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.categoryIndex, required this.total});
  final int categoryIndex;
  final double total;

  @override
  Widget build(BuildContext context) {
    final item = DemoData.expenseCategories[categoryIndex];
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(item.icon, color: item.color, size: 21),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                '${(item.amount / total * 100).round()}% do total',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Text(
          Formatters.currency(item.amount),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
