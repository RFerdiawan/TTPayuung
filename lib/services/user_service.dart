import 'package:get_storage/get_storage.dart';
import 'package:payuung_pribadi/models/user_model.dart';

class UserService {
  void saveUser(UserModel user) {
    final storage = GetStorage();
    storage.write('user', user.toJson());
  }

  UserModel? getUser() {
    final storage = GetStorage();
    Map<String, dynamic>? userData = storage.read('user');

    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }
}
