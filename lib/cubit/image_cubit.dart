import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageCubit extends Cubit<String?> {
  final box = GetStorage();
  final String key = 'profile_picture';

  ImageCubit() : super(null) {
    emit(box.read(key));
    emit(box.read('ktpPath'));
  }

  void updateProfilePicture(String path) {
    box.write(key, path);
    emit(path);
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<void> pickKTPImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Mengupdate state dengan path gambar yang baru
      emit(pickedFile.path);
      // Simpan ke GetStorage jika perlu
      await GetStorage().write('imagePath', pickedFile.path);
    }
  }

  // Fungsi untuk memilih gambar dari kamera
  Future<void> pickKTPImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Mengupdate state dengan path gambar yang baru
      emit(pickedFile.path);
      // Simpan ke GetStorage jika perlu
      await GetStorage().write('imagePath', pickedFile.path);
    }
  }

  // Memuat gambar yang disimpan sebelumnya dari GetStorage
  Future<void> loadSavedKTPImage() async {
    final savedImagePath = GetStorage().read<String>('imagePath');
    if (savedImagePath != null) {
      emit(savedImagePath);
    }
  }
}
