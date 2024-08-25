import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Meminta izin untuk Storage
  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }

  // Meminta izin untuk Kamera
  Future<bool> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    return status.isGranted;
  }

  // Meminta izin untuk Akses Foto
  Future<bool> requestPhotosPermission() async {
    PermissionStatus status = await Permission.photos.request();
    return status.isGranted;
  }

  // Meminta semua izin sekaligus
  Future<bool> requestAllPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.photos,
    ].request();

    // Cek apakah semua izin diberikan
    return statuses.values.every((status) => status.isGranted);
  }
}
