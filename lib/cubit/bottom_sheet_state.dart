part of 'bottom_sheet_cubit.dart';

abstract class BottomSheetState {}

class BottomSheetInitial extends BottomSheetState {}

class BottomSheetPageState extends BottomSheetState {
  final int pageIndex;
  final double sheetHeight;

  BottomSheetPageState(this.pageIndex, this.sheetHeight);
}
