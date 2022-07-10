import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectofiberpluss/src/blocs/events/UserEvents.dart';
import 'package:proyectofiberpluss/src/models/response_api.dart';
import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/repositories/UserRepository.dart';
import 'package:proyectofiberpluss/src/utils/validate_form.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class UserRegisterBloc extends GetxController {
  // Initialize Event for Bloc
  final StreamController<UserBase> _input = StreamController();
  StreamSink<UserBase> get sendEvent => _input.sink;

  // Initialize Inputs of form
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController planController = TextEditingController();
  TextEditingController costoController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  ImagePicker picker = ImagePicker();
  File? imageFile;

  // Initialize Repository
  final UserRepository userRepository = UserRepository();

  UserRegisterBloc() {
    _input.stream.listen(_onEvent);
  }

  void dispose() {
    _input.close();
  }

  void _onEvent(UserBase event) {
    if (event is DoRegisterEvent) {
      callRegisterUser(event.context2);
    }
  }

  void callRegisterUser(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String plan = planController.text;
    String precio = costoController.text;

    if (ValidateForm.isValidUserRegisterForm(email, name, lastname, phone,
        password, confirmPassword, plan, precio)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando datos...');

      User user = User(
          email: email,
          name: name,
          lastname: lastname,
          phone: phone,
          password: password,
          plan: plan,
          precio: precio);

      Stream stream = await userRepository.setDataUser(user, imageFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true) {
          GetStorage()
              .write('user', responseApi.data); // DATOS DEL USUARIO EN SESION
          goToHomePage();
        } else {
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }
      });
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/client/products/list', (route) => false);
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
          'GALERIA',
          style: TextStyle(color: Colors.black),
        ));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text(
          'CAMARA',
          style: TextStyle(color: Colors.black),
        ));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
