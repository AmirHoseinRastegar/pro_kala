part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailEvent {}


class CallProductDetailEvent extends ProductDetailEvent{

  final String id;

  CallProductDetailEvent(this.id);
}
