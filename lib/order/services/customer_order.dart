import '../models/order.dart';
import '../repositories/order_i_repository.dart';

class CustomerOrders {
  final OrderIRepository repo;
  CustomerOrders(this.repo);
  Future<List<Order>> call(int customerId) => repo.byCustomer(customerId);
}