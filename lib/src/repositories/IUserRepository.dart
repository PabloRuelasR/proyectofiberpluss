import 'dart:io';

import 'package:proyectofiberpluss/src/models/user.dart';

abstract class IUserRepository {
  Future<User> getDataUser(String email, String password);
  Future<Stream> setDataUser(User user, File file);
}
