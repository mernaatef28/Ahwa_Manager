import '../../menu/model/menu.dart';
import '../models/order.dart';
import '../repositories/order_i_repository.dart';

class AddItemToOrder {
  final OrderIRepository repo;
  AddItemToOrder(this.repo);

  Future<void> call(int orderId, MenuItem item) async {
    final current = await repo.byId(orderId);
    if (current == null) throw StateError('Order not found');

    final updated = Order(
      current.orderId,
      [...current.orderItems, item],
      current.customerId,
      status: current.status,
    );
    await repo.update(updated);
  }
}