import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi/cubit/greeting_cubit.dart';
import 'package:payuung_pribadi/cubit/refresh_cubit.dart';
import 'package:payuung_pribadi/cubit/wellness_product_cubit.dart';
import 'package:payuung_pribadi/models/user_model.dart';
import 'package:payuung_pribadi/models/wellness_product_model.dart';
import 'package:payuung_pribadi/services/image_service.dart';
import 'package:payuung_pribadi/services/user_service.dart';
import 'package:payuung_pribadi/views/pages/profile_page.dart';
import 'package:payuung_pribadi/views/pages/wellness_detail_page.dart';
import 'package:payuung_pribadi/views/widgets/custom_home_icon_button.dart';
import 'package:payuung_pribadi/views/widgets/custom_wellness_button.dart';
import 'package:payuung_pribadi/views/widgets/icon_button_with_badge.dart';

class HomePage extends StatelessWidget {
  final UserService _userService = UserService();
  final ImageService _imageService = ImageService();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? user = _userService.getUser();
    String? imgPath = _imageService.getImagePath();
    return BlocBuilder<RefreshCubit, bool>(
      builder: (context, isRefreshing) {
        return Scaffold(
          backgroundColor: Colors.amber,
          appBar: AppBar(
            title: BlocBuilder<GreetingCubit, GreetingState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.greeting,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      user?.fullName ?? 'Tidak ada nama',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
            backgroundColor: Colors.amber,
            actions: [
              IconButtonWithBadge(
                icon: Icons.notifications_none,
                iconColor: Colors.white,
                label: '',
                badgeCount: 0,
                onPressed: () {},
              ),
              InkWell(
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
                  user = _userService.getUser();
                  context.read<RefreshCubit>().refreshPage();
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 12,
                  ),
                  child: CircleAvatar(
                    backgroundImage: imgPath != null
                        ? FileImage(File(imgPath))
                        : AssetImage('assets/images/profileDefault.png')
                            as ImageProvider,
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  // padding: const EdgeInsets.all(2),
                  // margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(1000)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.amber,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Payuung Pribadi',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Payuung Karyawan',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),

                // Produk Keuangan
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Produk Keuangan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: [
                    CustomHomeIconButton(
                      icon: 'assets/icons/group.svg',
                      label: 'Urun',
                      color: Colors.green[700],
                    ),
                    const CustomHomeIconButton(
                      icon: 'assets/icons/hajj.svg',
                      label: 'Pembiayaan\nPorsi Haji',
                      color: Colors.lightGreen,
                    ),
                    const CustomHomeIconButton(
                      icon: 'assets/icons/finance.svg',
                      label: 'Financial\nCheck Up',
                      color: Colors.amber,
                    ),
                    const CustomHomeIconButton(
                      icon: 'assets/icons/car.svg',
                      label: 'Asuransi\nMobil',
                      color: Colors.blueGrey,
                    ),
                    const CustomHomeIconButton(
                      icon: 'assets/icons/burning-house.svg',
                      label: 'Asuransi\nProperti',
                      color: Colors.red,
                    )
                  ],
                ),

                // Kategori Pilihan
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kategori Pilihan',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Wishlist',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: [
                    const CustomHomeIconButton(
                      icon: 'assets/icons/travel.svg',
                      label: 'Hobi',
                      color: Colors.blue,
                    ),
                    const CustomHomeIconButton(
                      icon: 'assets/icons/merchandise.svg',
                      label: 'Merchandise',
                      color: Colors.amber,
                    ),
                    const CustomHomeIconButton(
                      icon: 'assets/icons/health.svg',
                      label: 'Gaya Hidup\nSehat',
                      color: Colors.blueGrey,
                    ),
                    const CustomHomeIconButton(
                      icon: 'assets/icons/chat.svg',
                      label: 'Konseling &\nRohani',
                      color: Colors.red,
                    ),
                    const CustomHomeIconButton(
                      icon: 'assets/icons/brain.svg',
                      label: 'Self\nDevelopment',
                      color: Colors.purple,
                    ),
                    const CustomHomeIconButton(
                      icon: 'assets/icons/card.svg',
                      label: 'Perencanaan\nKeuangan',
                      color: Colors.lightGreen,
                    ),
                    CustomHomeIconButton(
                      icon: 'assets/icons/mask.svg',
                      label: 'Konsultasi\nMedis',
                      color: Colors.green[700],
                    ),
                    const CustomHomeIconButton(
                      icon: 'assets/icons/menu-grid.svg',
                      label: 'Lihat Semua',
                      color: Colors.grey,
                    ),
                  ],
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Explore Wellness',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: Colors.grey[100],
                        ),
                        padding: EdgeInsets.all(8),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          value: 'Terpopuler',
                          items: ['Terpopuler', 'Terbaru', 'Diskon']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                ),

                BlocBuilder<WellnessProductCubit, WellnessProductState>(
                  builder: (context, state) {
                    if (state.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.error.isNotEmpty) {
                      return Center(child: Text(state.error));
                    }
                    if (state.products.isEmpty) {
                      return const Center(child: Text('No Products Found'));
                    }
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          WellnessProductModel product = state.products[index];
                          return CustomWellnessButton(
                            banner: product.image,
                            label: product.name,
                            price: product.price.toString(),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WellnessDetailPage(
                                          product: product,
                                        )),
                              );
                            },
                          );
                        });
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
