import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/models/Rol.dart';

class RolesController extends GetxController{

  User user = User.fromJson(GetStorage().read('user') ?? {});

  void goToPageRol(Rol rol){
    print(rol.route);
    Get.offNamedUntil(rol.route ?? '', (route) => false);
  }

}