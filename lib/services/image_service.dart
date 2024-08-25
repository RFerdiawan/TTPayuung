import 'package:get_storage/get_storage.dart';

class ImageService {
  void saveImagePath(String imagePath) {
    final storage = GetStorage();
    storage.write('profile_picture', imagePath);
  }

  String? getImagePath() {
    final storage = GetStorage();
    return storage.read('profile_picture');
  }
}
