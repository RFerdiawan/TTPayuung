import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

part 'master_data_state.dart';

class MasterDataCubit extends Cubit<MasterDataState> {
  MasterDataCubit() : super(const MasterDataState());

  void loadMasterData() async {
    try {
      emit(state.copyWith(isLoading: true));

      final box = GetStorage();

      // Mengambil data dan memeriksa tipe data
      final jenisKelamin =
          (box.read('jenis_kelamin') as List<dynamic>?)?.cast<String>() ?? [];
      final pendidikan =
          (box.read('pendidikan') as List<dynamic>?)?.cast<String>() ?? [];
      final statusPernikahan =
          (box.read('status_pernikahan') as List<dynamic>?)?.cast<String>() ??
              [];
      final jabatan =
          (box.read('jabatan') as List<dynamic>?)?.cast<String>() ?? [];
      final lamaBekerja =
          (box.read('lama_bekerja') as List<dynamic>?)?.cast<String>() ?? [];
      final sumberPendapatan =
          (box.read('sumber_pendapatan') as List<dynamic>?)?.cast<String>() ??
              [];
      final pendapatanKotor =
          (box.read('pendapatan_kotor') as List<dynamic>?)?.cast<String>() ??
              [];

      emit(state.copyWith(
        jenisKelamin: jenisKelamin,
        pendidikan: pendidikan,
        statusPernikahan: statusPernikahan,
        jabatan: jabatan,
        lamaBekerja: lamaBekerja,
        sumberPendapatan: sumberPendapatan,
        pendapatanKotor: pendapatanKotor,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
