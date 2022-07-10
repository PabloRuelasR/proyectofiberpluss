import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:proyectofiberpluss/src/models/order.dart';
import 'package:proyectofiberpluss/src/models/response_api.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/providers/orders_provider.dart';
import 'package:proyectofiberpluss/src/providers/users_provider.dart';

class AdministratorOrdersDetailController extends GetxController {

  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idTechnician = ''.obs;

  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;

  AdministratorOrdersDetailController() {
    print('Order: ${order.toJson()}');
    getTechnicianMen();
    getTotal();
  }

  void updateOrder() async {
    if (idTechnician.value != '') { // SI SELECCIONO EL DELIVERY
      order.idTechnician = idTechnician.value;
      ResponseApi responseApi = await ordersProvider.updateToDispatched(order);
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
      if (responseApi.success == true) {
        Get.offNamedUntil('/administrator/home', (route) => false);
      }
    }
    else {
      Get.snackbar('Peticion denegada', 'Debes asignar el tecnico');
    }
  }

  void getTechnicianMen() async {
    var result = await usersProvider.findTechnicianMen();
    users.clear();
    users.addAll(result);
  }

  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }

}