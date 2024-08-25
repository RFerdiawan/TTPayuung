import 'package:bloc/bloc.dart';

part 'bottom_sheet_state.dart';

class BottomSheetCubit extends Cubit<BottomSheetState> {
  BottomSheetCubit() : super(BottomSheetInitial());

  void updatePage(int pageIndex) {
    double sheetHeight = 0.15;
    if (pageIndex == -1) {
      sheetHeight = 0.4; // Expanded state
    }
    emit(BottomSheetPageState(pageIndex, sheetHeight));
  }

  void expandSheet() {
    emit(BottomSheetPageState(-1, 0.4)); // Expanded state
  }

  void collapseSheet() {
    emit(BottomSheetPageState(0, 0.15)); // Collapsed state
  }
}
