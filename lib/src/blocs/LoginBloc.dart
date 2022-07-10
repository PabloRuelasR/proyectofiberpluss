import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyectofiberpluss/src/blocs/events/UserEvents.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/repositories/UserRepository.dart';

class LoginBloc {
  // Initialize Event for Bloc
  final StreamController<UserBase> _input = StreamController();
  StreamSink<UserBase> get sendEvent => _input.sink;

  // Initialize Inputs of form
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Initialize Repository
  final UserRepository userRepository = UserRepository();

  LoginBloc() {
    _input.stream.listen(_onEvent);
  }

  void dispose() {
    _input.close();
  }

  void _onEvent(UserBase event) {
    if (event is DoLoginEvent) {
      print("entra aqui login");
      login();
    }
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (isValidForm(email, password)) {
      // ResponseApi responseApi = await usersProvider.login(email, password);

      User dataUser = await userRepository.getDataUser(email, password);
      String userEncode = jsonEncode(dataUser);

      if (dataUser.id != null) {
        // save in storage the result session
        GetStorage().write('user', jsonDecode(userEncode));

        User myUser = User.fromJson(GetStorage().read('user') ?? {});

        if (myUser.roles!.length > 1) {
          goToRolesPage();
        } else {
          goToClientHomePage();
        }
      }
    }
  }

  bool isValidForm(String email, String password) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el password');
      return false;
    }

    return true;
  }

  void goToClientHomePage() {
    Get.offNamedUntil('/client/home', (route) => false);
  }

  void goToRolesPage() {
    Get.offNamedUntil('/roles', (route) => false);
  }
}
