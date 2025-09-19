import 'package:flutter/material.dart';
import '../menu/repos/in_memory_menu_repos.dart';
import '../menu/service/menu_service.dart';
import '../order/repositories/in_memory_order_repository.dart';
import '../order/services/add_order.dart';
import '../order/services/complete_order.dart';
import '../order/services/list_orders.dart';
import '../report/services/sales_report_service.dart';


class AppDeps {
  // repos
  final InMemoryMenuRepository menuRepo = InMemoryMenuRepository();
  final InMemoryOrderRepository orderRepo = InMemoryOrderRepository();

  // services
  late final MenuService menuService = MenuService(menuRepo);
  late final AddOrder addOrder = AddOrder(orderRepo);
  late final CompleteOrder completeOrder = CompleteOrder(orderRepo);
  late final ListOrders listOrders = ListOrders(orderRepo);

  late final SalesReportService reportService = BasicSalesReportService();

}

/// Simple inherited container (optional but neat)
class DepsScope extends InheritedWidget {
  final AppDeps deps;
  const DepsScope({super.key, required this.deps, required super.child});

  static AppDeps of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DepsScope>()!.deps;

  @override
  bool updateShouldNotify(covariant DepsScope oldWidget) => deps != oldWidget.deps;
}
