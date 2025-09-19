// lib/presentation/screens/orders_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_deps.dart';
import '../models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrderStatus? _filter; // null = all

  @override
  Widget build(BuildContext context) {
    final deps = DepsScope.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: SegmentedButton<OrderStatus?>(
            segments: const [
              ButtonSegment(value: null, label: Text('All')),
              ButtonSegment(value: OrderStatus.pending, label: Text('Pending')),
              ButtonSegment(value: OrderStatus.completed, label: Text('Completed')),
            ],
            selected: {_filter},
            onSelectionChanged: (s) => setState(() => _filter = s.first),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Order>>(
            stream: deps.listOrders.watchAll(),
            builder: (context, snap) {
              var orders = (snap.data ?? const <Order>[]).toList()
                ..sort((a, b) => b.orderId.compareTo(a.orderId));

              if (_filter != null) {
                orders = orders.where((o) => o.status == _filter).toList();
              }

              if (orders.isEmpty) {
                return const Center(child: Text('No orders.'));
              }

              return ListView.separated(
                itemCount: orders.length,
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemBuilder: (_, i) {
                  final o = orders[i];
                  final isCompleted = o.status == OrderStatus.completed;
                  return ListTile(
                    leading: CircleAvatar(child: Text(o.orderItems.length.toString())),
                    title: Text('Order #${o.orderId} • Customer ${o.customerId}'),
                    subtitle: Text(
                      '${o.orderItems.map((e) => e.name).join(", ")}\n'
                          'Total: ${o.totalPrice.toStringAsFixed(2)} EGP',
                      maxLines: 2,
                    ),
                    isThreeLine: true,
                    trailing: isCompleted
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : IconButton(
                      icon: const Icon(Icons.check),
                      tooltip: 'Mark Completed',
                      onPressed: () => deps.completeOrder(o.orderId),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
