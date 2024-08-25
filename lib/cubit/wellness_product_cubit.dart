import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payuung_pribadi/models/wellness_product_model.dart';

part 'wellness_product_state.dart';

class WellnessProductCubit extends Cubit<WellnessProductState> {
  final GetStorage _storage = GetStorage();
  static const String _masterDataKey = 'wellness_product_master_data';

  WellnessProductCubit() : super(const WellnessProductState());

  void fetchProducts() async {
    emit(const WellnessProductState(loading: true));
    try {
      List<dynamic> productsJson = _storage.read(_masterDataKey) ?? [];
      List<WellnessProductModel> products = productsJson
          .map((productJson) => WellnessProductModel.fromJson(productJson))
          .toList();
      emit(WellnessProductState(products: products, loading: false));
    } catch (e) {
      emit(const WellnessProductState(
          error: 'Failed to load products', loading: false));
    }
  }
}
