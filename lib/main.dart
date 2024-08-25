import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi/cubit/bottom_sheet_cubit.dart';
import 'package:payuung_pribadi/cubit/greeting_cubit.dart';
import 'package:payuung_pribadi/cubit/image_cubit.dart';
import 'package:payuung_pribadi/cubit/refresh_cubit.dart';
import 'package:payuung_pribadi/cubit/wellness_product_cubit.dart';
import 'package:payuung_pribadi/models/user_model.dart';
import 'package:payuung_pribadi/services/user_service.dart';
import 'package:payuung_pribadi/services/wellness_product_service.dart';
import 'package:payuung_pribadi/views/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  _initializeMasterData();
  WellnessProductService.saveMasterData();

  runApp(const MyApp());
}

void _initializeMasterData() {
  final GetStorage storage = GetStorage();
  final UserService userService = UserService();

  if (storage.read('jenis_kelamin') == null) {
    storage.write('jenis_kelamin', ['Laki-laki', 'Perempuan']);
  }

  if (storage.read('pendidikan') == null) {
    storage.write(
        'pendidikan', ['SD', 'SMP', 'SMA', 'D1', 'D2', 'D3', 'S1', 'S2', 'S3']);
  }

  if (storage.read('status_pernikahan') == null) {
    storage
        .write('status_pernikahan', ['Belum Kawin', 'Kawin', 'Janda', 'Duda']);
  }

  if (storage.read('jabatan') == null) {
    storage.write('jabatan',
        ['Non-Staf', 'Staf', 'Supervisor', 'Manajer', 'Direktur', 'Lainnya']);
  }

  if (storage.read('lama_bekerja') == null) {
    storage.write('lama_bekerja',
        ['<6 Bulan', '6 Bulan - 1 Tahun', '1-2 Tahun', '>2 Tahun']);
  }

  if (storage.read('sumber_pendapatan') == null) {
    storage.write('sumber_pendapatan', [
      'Gaji',
      'Keuntungan Bisnis',
      'Bunga Tabungan',
      'Warisan',
      'Dana dari orang tua atau anak',
      'Undian',
      'Keuntungan Investasi',
      'Lainnya'
    ]);
  }

  if (storage.read('pendapatan_kotor') == null) {
    storage.write('pendapatan_kotor', [
      '<10 Juta',
      '10-50 Juta',
      '50-100 Juta',
      '100-500 Juta',
      '500 Juta-1 Milyar',
      '>1Milyar'
    ]);
  }

  userService.saveUser(UserModel(
    fullName: "Randy Test",
    birthDate: DateTime(1990, 5, 15),
    gender: "Laki-Laki",
    email: "randytest@test.com",
    phoneNumber: "08123456789",
    education: "S1",
    maritalStatus: "Belum Kawin",
    ktpPath: "",
    nik: "1234567890123456",
    ktpAddress: "Jl. Sudirman No. 123",
    ktpProvince: "DKI Jakarta",
    ktpCity: "Jakarta Pusat",
    ktpDistrict: "Tanah Abang",
    ktpSubDistrict: "Bendungan Hilir",
    ktpPostalCode: "10210",
    domicileAddress: "Jl. Thamrin No. 456",
    domicileProvince: "DKI Jakarta",
    domicileCity: "Jakarta Selatan",
    domicileDistrict: "Kebayoran Baru",
    domicileSubDistrict: "Senayan",
    domicilePostalCode: "12190",
    companyName: "PT. Test Bersama 123",
    companyAddress: "Jl. Gatot Subroto No. 789",
    jobTitle: "Supervisor",
    yearsOfService: ">2 Tahun",
    incomeSource: "Gaji",
    annualGrossIncome: '50-100 Juta',
    bankName: "Bank BCA",
    bankBranch: "Kantor Cabang Sudirman",
    bankAccountNumber: "1234567890",
    accountHolderName: "Randy Test",
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BottomSheetCubit(),
          ),
          BlocProvider(
            create: ((context) => GreetingCubit()),
          ),
          BlocProvider(
            create: ((context) => WellnessProductCubit()..fetchProducts()),
          ),
          BlocProvider(
            create: ((context) => RefreshCubit()),
          ),
          BlocProvider(
            create: ((context) => ImageCubit()),
          ),
        ],
        child: const MainPage(),
      ),
    );
  }
}
