


import '../../menu/model/menu.dart';

enum OrderStatus { pending, completed }

class Order {
  final int orderId;
  final int customerId;
  final List<MenuItem> orderItems;
  OrderStatus status;

  Order(this.orderId, this.orderItems, this.customerId, {this.status = OrderStatus.pending});

  double get totalPrice =>
      orderItems.fold(0.0, (sum, item) => sum + item.price); // if MenuItem has price
}
