
import '../models/order.dart';
import '../repositories/order_i_repository.dart';

class ListPendingOrders {
  final OrderIRepository repo;
  ListPendingOrders(this.repo);
  Future<List<Order>> call() => repo.listPending();
}
