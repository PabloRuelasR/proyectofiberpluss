import 'package:get/get.dart';
import 'package:proyectofiberpluss/src/models/order.dart';
import 'package:proyectofiberpluss/src/providers/orders_provider.dart';

class AdministratorOrdersListController extends GetxController {

  OrdersProvider ordersProvider = OrdersProvider();
  List<String> status = <String>['PAGADO', 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'].obs;

  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.findByStatus(status);
  }

  void goToOrderDetail (Order order) {
    Get.toNamed('/administrator/orders/detail', arguments: {
      'order': order.toJson()
    });
  }
}