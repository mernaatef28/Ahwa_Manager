

import '../../order/models/order.dart';

class SalesReport {
  final int totalOrders;
  final Map<String, int> topDrinksCounts; // name -> count
  final double totalRevenue;
  SalesReport(this.totalOrders, this.topDrinksCounts, this.totalRevenue);
}

abstract class SalesReportService {
  Future<SalesReport> generate(List<Order> orders);
}

// Simple implementation
class BasicSalesReportService implements SalesReportService {
  @override
  Future<SalesReport> generate(List<Order> orders) async {
    int totalOrders = orders.length;
    final counts = <String, int>{};
    double revenue = 0.0;

    for (final o in orders) {
      revenue += o.totalPrice;
      for (final item in o.orderItems) {
        counts.update(item.name , (v) => v + 1, ifAbsent: () => 1);
      }
    }

    return SalesReport(totalOrders, counts, revenue);
  }
}
