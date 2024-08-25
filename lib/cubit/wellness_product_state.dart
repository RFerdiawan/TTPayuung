part of 'wellness_product_cubit.dart';

class WellnessProductState extends Equatable {
  final List<WellnessProductModel> products;
  final bool loading;
  final String error;

  const WellnessProductState({
    this.products = const [],
    this.loading = false,
    this.error = '',
  });

  @override
  List<Object?> get props => [products, loading, error];
}
