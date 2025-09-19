
import '../models/order.dart';
import '../repositories/order_i_repository.dart';

class AddOrder {
  final OrderIRepository repo;
  AddOrder(this.repo);

  Future<void> call(Order order) => repo.add(order);
}