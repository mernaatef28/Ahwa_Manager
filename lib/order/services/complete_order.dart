import '../models/order.dart';
import '../repositories/order_i_repository.dart';

class CompleteOrder {
  final OrderIRepository repo;
  CompleteOrder(this.repo);

  Future<void> call(int orderId) async {
    final current = await repo.byId(orderId);
    if (current == null) throw StateError('Order not found');
    if (current.status == OrderStatus.completed) return;

    final updated = Order(
      current.orderId,
      current.orderItems,
      current.customerId,
      status: OrderStatus.completed,
    );
    await repo.update(updated);
  }
}