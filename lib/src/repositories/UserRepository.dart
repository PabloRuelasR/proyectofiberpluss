import 'package:proyectofiberpluss/src/models/user.dart';
import 'package:proyectofiberpluss/src/providers/users_provider.dart';

import 'IUserRepository.dart';

class UserRepository implements IUserRepository {
  UsersProvider usersProvider = UsersProvider();

  @override
  Future<User> getDataUser(email, password) async {
    var response = await usersProvider.login(email, password);
    return User.fromJson(response.data);
  }
}
