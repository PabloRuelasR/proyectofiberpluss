import 'package:proyectofiberpluss/src/models/user.dart';

abstract class IUserRepository {
  Future<User> getDataUser(email, password);
}
