import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyectofiberpluss/src/models/order.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/providers/orders_provider.dart';

class TechnicianOrdersListController extends GetxController {

  OrdersProvider ordersProvider = OrdersProvider();
  List<String> status = <String>['DESPACHADO', 'EN CAMINO', 'ENTREGADO'].obs;

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.findByTechnicianAndStatus(user.id ?? '0', status);
  }

  void goToOrderDetail (Order order) {
    Get.toNamed('/technician/orders/detail', arguments: {
      'order': order.toJson()
    });
  }
}