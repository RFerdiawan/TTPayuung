part of 'master_data_cubit.dart';

class MasterDataState extends Equatable {
  final List<String> jenisKelamin;
  final List<String> pendidikan;
  final List<String> statusPernikahan;
  final List<String> jabatan;
  final List<String> lamaBekerja;
  final List<String> sumberPendapatan;
  final List<String> pendapatanKotor;
  final bool isLoading;
  final String errorMessage;

  const MasterDataState({
    this.jenisKelamin = const [],
    this.pendidikan = const [],
    this.statusPernikahan = const [],
    this.jabatan = const [],
    this.lamaBekerja = const [],
    this.sumberPendapatan = const [],
    this.pendapatanKotor = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [
        jenisKelamin,
        pendidikan,
        statusPernikahan,
        jabatan,
        lamaBekerja,
        sumberPendapatan,
        pendapatanKotor,
        isLoading,
        errorMessage,
      ];

  MasterDataState copyWith({
    List<String>? jenisKelamin,
    List<String>? pendidikan,
    List<String>? statusPernikahan,
    List<String>? jabatan,
    List<String>? lamaBekerja,
    List<String>? sumberPendapatan,
    List<String>? pendapatanKotor,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MasterDataState(
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      pendidikan: pendidikan ?? this.pendidikan,
      statusPernikahan: statusPernikahan ?? this.statusPernikahan,
      jabatan: jabatan ?? this.jabatan,
      lamaBekerja: lamaBekerja ?? this.lamaBekerja,
      sumberPendapatan: sumberPendapatan ?? this.sumberPendapatan,
      pendapatanKotor: pendapatanKotor ?? this.pendapatanKotor,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

abstract class MasterDataEvent extends Equatable {
  const MasterDataEvent();

  @override
  List<Object> get props => [];
}

class LoadMasterData extends MasterDataEvent {}
