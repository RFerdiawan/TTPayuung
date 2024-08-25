import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshCubit extends Cubit<bool> {
  RefreshCubit() : super(false);

  // Fungsi untuk merefresh halaman
  void refreshPage() {
    emit(true);
    emit(false);
  }
}
