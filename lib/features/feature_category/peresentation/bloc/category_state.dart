part of 'category_bloc.dart';

@immutable
sealed class CategoryState extends Equatable {}

final class CategoryInitial extends CategoryState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class CategoryLoading extends CategoryState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class CategorySuccess extends CategoryState {
  final HomeModel homeModel;

  CategorySuccess(this.homeModel);

  @override
  List<Object?> get props => [homeModel];

}

final class CategoryError extends CategoryState {
  @override
  List<Object?> get props => throw UnimplementedError();
}


