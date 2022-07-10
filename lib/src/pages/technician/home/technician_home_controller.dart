import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/providers/push_notifications_provider.dart';

class TechnicianHomeController extends GetxController {

  var indexTab = 0.obs;
  PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  TechnicianHomeController() {
    saveToken();
  }

  void changeTab(int index) {
    indexTab.value = index;
  }

  void saveToken() {
    if (user.id != null) {
      pushNotificationsProvider.saveToken(user.id!);
    }
  }

  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false); // ELIMINAR EL HISTORIAL DE PANTALLAS
  }



}