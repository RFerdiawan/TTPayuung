import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi/cubit/bottom_sheet_cubit.dart';
import 'package:payuung_pribadi/cubit/greeting_cubit.dart';
import 'package:payuung_pribadi/services/permission_service.dart';
import 'package:payuung_pribadi/views/pages/address_page.dart';
import 'package:payuung_pribadi/views/pages/cart_page.dart';
import 'package:payuung_pribadi/views/pages/friends_page.dart';
import 'package:payuung_pribadi/views/pages/home_page.dart';
import 'package:payuung_pribadi/views/pages/my_voucher_page.dart';
import 'package:payuung_pribadi/views/pages/search_page.dart';
import 'package:payuung_pribadi/views/pages/transaction_page.dart';
import 'package:payuung_pribadi/views/widgets/custom_icon_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  final PermissionService _permissionService = PermissionService();

  @override
  void initState() {
    super.initState();
    _requestPermissionsOnStartup();
    _pageController.addListener(_onPageChanged);
    context.read<GreetingCubit>().updateGreeting();
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    context.read<BottomSheetCubit>().updatePage(_pageController.page!.round());
  }

  Future<void> _requestPermissionsOnStartup() async {
    // ignore: unused_local_variable
    bool allGranted = await _permissionService.requestAllPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              HomePage(),
              const SearchPage(),
              const CartPage(),
            ],
          ),
          BlocBuilder<BottomSheetCubit, BottomSheetState>(
            builder: (context, state) {
              double minChildSize = 0.15;
              double maxChildSize = 0.3;
              if (state is BottomSheetPageState) {
                minChildSize = state.sheetHeight;
                maxChildSize = state.sheetHeight;
              }

              return DraggableScrollableSheet(
                initialChildSize: minChildSize,
                minChildSize: minChildSize,
                maxChildSize: maxChildSize,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (state is BottomSheetPageState &&
                                state.pageIndex == -1) {
                              context.read<BottomSheetCubit>().collapseSheet();
                            } else {
                              context.read<BottomSheetCubit>().expandSheet();
                            }
                          },
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 300),
                            turns: (state is BottomSheetPageState &&
                                    state.pageIndex == -1)
                                ? 0.0
                                : 0.5,
                            child: const Icon(
                              Icons.expand_more,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GridView.count(
                            childAspectRatio: 1.6,
                            padding: EdgeInsets.zero,
                            controller: scrollController,
                            crossAxisCount: 3,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            children: [
                              CustomIconButton(
                                  icon: 'assets/icons/home.svg',
                                  label: "Beranda",
                                  pageIndex: 0,
                                  onPressed: () {
                                    _pageController.jumpToPage(0);
                                    context
                                        .read<BottomSheetCubit>()
                                        .updatePage(0);
                                  }),
                              CustomIconButton(
                                  icon: 'assets/icons/search.svg',
                                  label: "Cari",
                                  pageIndex: 1,
                                  onPressed: () {
                                    _pageController.jumpToPage(1);
                                    context
                                        .read<BottomSheetCubit>()
                                        .updatePage(1);
                                  }),
                              CustomIconButton(
                                icon: 'assets/icons/cart.svg',
                                label: "Keranjang",
                                pageIndex: 10,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const CartPage()),
                                  );
                                },
                              ),
                              CustomIconButton(
                                  icon: 'assets/icons/transaction.svg',
                                  label: "Daftar Transaksi",
                                  pageIndex: 3,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TransactionPage()),
                                    );
                                  }),
                              CustomIconButton(
                                  icon: 'assets/icons/voucher.svg',
                                  label: "Voucher Saya",
                                  pageIndex: 4,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyVoucherPage()),
                                    );
                                  }),
                              CustomIconButton(
                                  icon: 'assets/icons/location.svg',
                                  label: "Alamat Pengiriman",
                                  pageIndex: 5,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddressPage()),
                                    );
                                  }),
                              CustomIconButton(
                                  icon: 'assets/icons/friends.svg',
                                  label: "Daftar Teman",
                                  pageIndex: 6,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FriendsPage()),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
