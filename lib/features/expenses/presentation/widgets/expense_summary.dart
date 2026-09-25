import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';

class ExpenseMonthData {
  const ExpenseMonthData({required this.month, required this.amount});

  final DateTime month;
  final double amount;
}

class ExpenseSummary extends StatefulWidget {
  const ExpenseSummary({
    super.key,
    required this.total,
    required this.periodLabel,
    required this.average,
    required this.recordCount,
    required this.months,
    required this.selectedMonth,
    required this.onMonthSelected,
  });

  final double total;
  final String periodLabel;
  final double average;
  final int recordCount;
  final List<ExpenseMonthData> months;
  final DateTime? selectedMonth;
  final ValueChanged<DateTime?> onMonthSelected;

  @override
  State<ExpenseSummary> createState() => _ExpenseSummaryState();
}

class _ExpenseSummaryState extends State<ExpenseSummary> {
  int get _activeIndex {
    if (widget.selectedMonth == null) return -1;
    return widget.months.indexWhere(
      (item) =>
          item.month.year == widget.selectedMonth!.year &&
          item.month.month == widget.selectedMonth!.month,
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxAmount = widget.months.fold<double>(
      0,
      (maximum, item) => item.amount > maximum ? item.amount : maximum,
    );
    final selected = _activeIndex == -1 ? null : widget.months[_activeIndex];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppColors.navy, AppColors.blue],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total · ${widget.periodLabel}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      Formatters.currency(widget.total),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -.7,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Média mensal ${Formatters.currency(widget.average)}  ·  '
                      '${widget.recordCount} ${widget.recordCount == 1 ? 'registo' : 'registos'}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    selected == null
                        ? 'Evolução mensal'
                        : _monthName(selected.month.month),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .72),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selected == null
                        ? 'Toque numa barra'
                        : Formatters.currency(selected.amount),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white.withValues(
                        alpha: selected == null ? .7 : 1,
                      ),
                      fontWeight: selected == null
                          ? FontWeight.w500
                          : FontWeight.w700,
                      fontSize: selected == null ? 11 : 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (widget.months.isNotEmpty) ...[
            const SizedBox(height: 22),
            SizedBox(
              height: 82,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var i = 0; i < widget.months.length; i++)
                    Expanded(
                      child: InkWell(
                        onTap: () => widget.onMonthSelected(
                          i == _activeIndex ? null : widget.months[i].month,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: FractionallySizedBox(
                                    heightFactor: maxAmount == 0
                                        ? .04
                                        : (widget.months[i].amount / maxAmount)
                                              .clamp(.04, 1),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: i == _activeIndex
                                            ? Colors.white
                                            : Colors.white.withValues(
                                                alpha: .28,
                                              ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _monthShort(widget.months[i].month.month),
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: .68),
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _monthShort(int month) => const [
    'jan',
    'fev',
    'mar',
    'abr',
    'mai',
    'jun',
    'jul',
    'ago',
    'set',
    'out',
    'nov',
    'dez',
  ][month - 1];

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
}
