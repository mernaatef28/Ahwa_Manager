import 'package:flutter/material.dart';
import '../../core/app_deps.dart';
import '../../order/models/order.dart';
import '../services/sales_report_service.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deps = DepsScope.of(context);
    return StreamBuilder<List<Order>>(
      stream: deps.listOrders.watchAll(),
      builder: (context, snap) {
        final orders = snap.data ?? const <Order>[];
        return FutureBuilder<SalesReport>(
          future: deps.reportService.generate(orders),
          builder: (context, repSnap) {
            if (!repSnap.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Generating report...',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }

            final r = repSnap.data!;
            final top = r.topDrinksCounts.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value));

            if (orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.analytics_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No data to analyze',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Reports will be generated when orders are available',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Summary Cards Section
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.receipt_long,
                        title: 'Total Orders',
                        value: r.totalOrders.toString(),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        textColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.payments,
                        title: 'Total Revenue',
                        value: '${r.totalRevenue.toStringAsFixed(0)} EGP',
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        textColor: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Average Revenue Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.trending_up,
                          color: Theme.of(context).colorScheme.onTertiary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Average Order Value',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onTertiaryContainer,
                            ),
                          ),
                          Text(
                            r.totalOrders > 0
                                ? '${(r.totalRevenue / r.totalOrders).toStringAsFixed(2)} EGP'
                                : '0.00 EGP',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onTertiaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Top Drinks Section
                Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Top Drinks',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                if (top.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.local_cafe_outlined,
                            size: 48,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No drinks data available',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...top.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isTop3 = index < 3;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isTop3
                                ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isTop3
                                  ? Theme.of(context).colorScheme.primaryContainer
                                  : Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: isTop3
                                  ? Icon(
                                _getRankIcon(index),
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                size: 20,
                              )
                                  : Text(
                                '${index + 1}',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            item.key,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: isTop3 ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isTop3
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${item.value} orders',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: isTop3
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                const SizedBox(height: 24),
              ],
            );
          },
        );
      },
    );
  }

  IconData _getRankIcon(int index) {
    switch (index) {
      case 0: return Icons.looks_one;
      case 1: return Icons.looks_two;
      case 2: return Icons.looks_3;
      default: return Icons.local_cafe;
    }
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final Color textColor;

  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: textColor,
            size: 28,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: textColor.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}