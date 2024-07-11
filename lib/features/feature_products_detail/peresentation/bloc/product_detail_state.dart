part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailState {}

 class ProductDetailInitial extends ProductDetailState {}

 class ProductDetailLoading extends ProductDetailState {}

 class ProductDetailSuccess extends ProductDetailState {
  final ProductDetailModel productDetailModel;

  ProductDetailSuccess(this.productDetailModel);

}

 class ProductDetailError extends ProductDetailState {

  final String errorMsg;
  ProductDetailError(this.errorMsg);
}
