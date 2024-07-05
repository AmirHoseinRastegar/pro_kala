part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

 class CategoryInitial extends CategoryState {

}

 class CategoryLoading extends CategoryState {

}

 class CategorySuccess extends CategoryState {
  final CategoryModel categoryModel;

  CategorySuccess(this.categoryModel);

  @override
  List<Object?> get props => [categoryModel];

}

 class CategoryError extends CategoryState {
  @override
  List<Object?> get props => throw UnimplementedError();
}


