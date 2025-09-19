
import '../models/order.dart';
import '../repositories/order_i_repository.dart';

class ListOrders {
  final OrderIRepository repo;
  ListOrders(this.repo);

  /// Stream of all orders (pending + completed)
  Stream<List<Order>> watchAll() => repo.watchAll();

  /// If you also want direct lists:
  Future<List<Order>> pending() => repo.listPending();
  Future<List<Order>> completed() => repo.listCompleted();
}
