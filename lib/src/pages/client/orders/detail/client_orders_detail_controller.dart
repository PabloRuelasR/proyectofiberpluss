import 'package:get/get.dart';
import 'package:proyectofiberpluss/src/models/order.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/providers/orders_provider.dart';
import 'package:proyectofiberpluss/src/providers/users_provider.dart';

class ClientOrdersDetailController extends GetxController {

  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idTechnician = ''.obs;

  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;

  ClientOrdersDetailController() {
    print('Order: ${order.toJson()}');
    getTotal();
  }

  void goToOrderMap() {
    Get.toNamed('/client/orders/map', arguments: {
      'order': order.toJson()
    });
  }

  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }

}