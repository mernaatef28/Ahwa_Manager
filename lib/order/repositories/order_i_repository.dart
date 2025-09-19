
import '../models/order.dart';

abstract class OrderIRepository {
  Future<void> add(Order order);
  Future<void> remove(int orderId);
  Future<void> update(Order order);

  Future<Order?> byId(int orderId);

  Future<List<Order>> byCustomer(int customerId);
  Future<List<Order>> listPending();
  Future<List<Order>> listCompleted();

  // Optional realtime/observer style if you want UI to react
  Stream<List<Order>> watchAll();
}
