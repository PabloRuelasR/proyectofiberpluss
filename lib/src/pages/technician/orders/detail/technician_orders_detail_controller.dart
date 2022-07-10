import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:proyectofiberpluss/src/models/order.dart';
import 'package:proyectofiberpluss/src/models/response_api.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/providers/orders_provider.dart';
import 'package:proyectofiberpluss/src/providers/users_provider.dart';

class TechnicianOrdersDetailController extends GetxController {

  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idTechnician = ''.obs;

  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;

  TechnicianOrdersDetailController() {
    print('Order: ${order.toJson()}');
    getTotal();
  }

  void updateOrder() async {
    ResponseApi responseApi = await ordersProvider.updateToOnTheWay(order);
    Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
    if (responseApi.success == true) {
      goToOrderMap();
    }
  }

  void goToOrderMap() {
    Get.toNamed('/technician/orders/map', arguments: {
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