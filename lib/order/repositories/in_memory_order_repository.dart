import 'dart:async';
import '../../menu/model/menu.dart';
import '../models/order.dart';

import 'order_i_repository.dart';

class InMemoryOrderRepository implements OrderIRepository {
  final _map = <int, Order>{};
  final _controller = StreamController<List<Order>>.broadcast();

  InMemoryOrderRepository() {
    // 🔹 menu items (same ones your menu repo uses)
    final tea = MenuItem(1, "Shai (Tea)", 10 ,"");
    final coffee = MenuItem(2, "Turkish Coffee", 15 ,"");
    final hibiscus = MenuItem(3, "Hibiscus Tea", 12,"");

    // 🔹 placeholder orders
    final seedOrders = [
      Order(1001, [tea], 1), // customer 1 → 1 tea
      Order(1002, [coffee, hibiscus], 2), // customer 2 → 1 coffee + 1 hibiscus
      Order(1003, [coffee, coffee], 3, status: OrderStatus.completed), // customer 3 → 2 coffees
      Order(1004, [tea, tea, hibiscus], 4), // customer 4 → 2 teas + 1 hibiscus
      Order(1005, [coffee], 5, status: OrderStatus.completed), // customer 5 → 1 coffee
    ];

    for (final o in seedOrders) {
      _map[o.orderId] = o;
    }
    _emit();
  }

  void _emit() => _controller.add(_map.values.toList());

  @override
  Future<void> add(Order order) async {
    _map[order.orderId] = order;
    _emit();
  }

  @override
  Future<void> remove(int orderId) async {
    _map.remove(orderId);
    _emit();
  }

  @override
  Future<void> update(Order order) async {
    _map[order.orderId] = order;
    _emit();
  }

  @override
  Future<Order?> byId(int orderId) async => _map[orderId];

  @override
  Future<List<Order>> byCustomer(int customerId) async =>
      _map.values.where((o) => o.customerId == customerId).toList();

  @override
  Future<List<Order>> listPending() async =>
      _map.values.where((o) => o.status == OrderStatus.pending).toList();

  @override
  Future<List<Order>> listCompleted() async =>
      _map.values.where((o) => o.status == OrderStatus.completed).toList();

  @override
  Stream<List<Order>> watchAll() => _controller.stream;
}
