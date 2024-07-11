import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pro_kala/features/feature_products_detail/data/model/product_detail_model.dart';
import 'package:pro_kala/features/feature_products_detail/data/repository/product_detail_repository.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailRepository productDetailRepository;

  ProductDetailBloc(this.productDetailRepository)
      : super(ProductDetailInitial()) {
    on<CallProductDetailEvent>(_callProductDetailBloc);
  }

  Future<void> _callProductDetailBloc(
      CallProductDetailEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    try {
      final ProductDetailModel productDetailModel =
          await productDetailRepository.fetchProductDetailRepository(event.id);

      emit(ProductDetailSuccess(productDetailModel));
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      emit(ProductDetailInitial());
    }
  }
}
