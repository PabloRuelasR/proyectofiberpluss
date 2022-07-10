import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/pages/client/products/detail/client_plan_detail_page.dart';

class ClientPlanListController extends GetxController{

  var user = User.fromJson(GetStorage().read('user')).obs;

  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false); // ELIMINAR EL HISTORIAL DE PANTALLAS
  }

  void goToProfileUpdate(){
    Get.toNamed('/client/profile/update');
  }

  void openBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientPlanDetailPage()
    );
  }

}