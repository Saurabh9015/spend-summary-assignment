import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../utils/format_utils.dart';

class SpendingInsightsCard extends StatelessWidget {
  const SpendingInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final topCategory = DummyData.topSpendingCategory;
    final topTransaction = DummyData.highestTransaction;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _InsightColumn(
                label: 'Top category',
                title: topCategory.name,
                value: FormatUtils.compactCurrency(topCategory.amount),
                icon: topCategory.icon,
                colorScheme: colorScheme,
                theme: theme,
              ),
            ),
            Container(
              width: 1,
              height: 52,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: colorScheme.outlineVariant.withValues(alpha: 0.45),
            ),
            Expanded(
              child: _InsightColumn(
                label: 'Highest spend',
                title: topTransaction.title,
                value: FormatUtils.currency(topTransaction.amount),
                icon: FormatUtils.iconForCategory(topTransaction.category),
                colorScheme: colorScheme,
                theme: theme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightColumn extends StatelessWidget {
  const _InsightColumn({
    required this.label,
    required this.title,
    required this.value,
    required this.icon,
    required this.colorScheme,
    required this.theme,
  });

  final String label;
  final String title;
  final String value;
  final IconData icon;
  final ColorScheme colorScheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(icon, size: 18, color: colorScheme.primary),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
