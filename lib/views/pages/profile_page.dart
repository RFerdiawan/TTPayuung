import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payuung_pribadi/cubit/image_cubit.dart';
import 'package:payuung_pribadi/cubit/refresh_cubit.dart';
import 'package:payuung_pribadi/models/user_model.dart';
import 'package:payuung_pribadi/services/user_service.dart';
import 'package:payuung_pribadi/views/pages/personal_information_page.dart';
import 'package:payuung_pribadi/views/widgets/custom_elevated_button.dart';

class ProfilePage extends StatelessWidget {
  final UserService _userService = UserService();
  ProfilePage({super.key});

  final ImagePicker picker = ImagePicker();
  Future<void> pickImage(BuildContext context) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Update profile picture with the selected image
      context.read<ImageCubit>().updateProfilePicture(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = _userService.getUser();
    // String? imgPath = _imageService.getImagePath();

    return BlocProvider(
      create: (context) => RefreshCubit(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          centerTitle: true,
          title: const Text('Profile'),
        ),
        body: BlocProvider(
          create: (context) => ImageCubit(),
          child: BlocBuilder<RefreshCubit, bool>(
            builder: (context, isRefreshing) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      // Avatar
                      Row(
                        children: [
                          Stack(
                            children: [
                              BlocBuilder<ImageCubit, String?>(
                                builder: (context, profilePath) {
                                  return CircleAvatar(
                                    radius: 28,
                                    backgroundImage: profilePath != null
                                        ? FileImage(File(profilePath))
                                        : const AssetImage(
                                                'assets/images/profileDefault.png')
                                            as ImageProvider,
                                  );
                                },
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey, width: 2),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => pickImage(context),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.fullName ?? 'Tidak ada nama',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('masuk dengan Google'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomElevatedButton(
                        label: 'Informasi Pribadi',
                        icon: Icons.person_2_outlined,
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PersonalInformationPage()),
                          );
                          user = _userService.getUser();
                          context.read<RefreshCubit>().refreshPage();
                        },
                      ),
                      CustomElevatedButton(
                        label: 'Syarat & Ketentuan',
                        icon: Icons.file_copy_outlined,
                        onPressed: () {},
                      ),
                      CustomElevatedButton(
                        label: 'Bantuan',
                        icon: Icons.chat_outlined,
                        onPressed: () {},
                      ),
                      CustomElevatedButton(
                        label: 'Kebijakan Privasi',
                        icon: Icons.verified_user_outlined,
                        onPressed: () {},
                      ),
                      CustomElevatedButton(
                        label: 'Log Out',
                        icon: Icons.power_settings_new_outlined,
                        onPressed: () {},
                      ),
                      CustomElevatedButton(
                        label: 'Haus Akun',
                        icon: Icons.delete_outline,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
