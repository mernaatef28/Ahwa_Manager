import 'package:smart_ahwa_app/menu/model/menu.dart';

class Order {
  int orderId ;
  List<MenuItem> orderItems ;
  Order(this.orderId , this.orderItems) ;
}