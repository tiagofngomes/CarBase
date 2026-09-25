import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';

class ExpenseSummary extends StatelessWidget {
  const ExpenseSummary({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    const monthly = [82.0, 128.0, 94.0, 172.0, 108.0, 154.0];
    const labels = ['abr', 'mai', 'jun', 'jul', 'ago', 'set'];
    final max = monthly.reduce((a, b) => a > b ? a : b);

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
          Text(
            'Total em 2026',
            style: TextStyle(
              color: Colors.white.withValues(alpha: .68),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            Formatters.currency(total),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -.7,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Média mensal  120,80 €',
            style: TextStyle(
              color: Colors.white.withValues(alpha: .68),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 82,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < monthly.length; i++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FractionallySizedBox(
                                heightFactor: monthly[i] / max,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: i == monthly.length - 1
                                        ? Colors.white
                                        : Colors.white.withValues(alpha: .28),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            labels[i],
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: .65),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
