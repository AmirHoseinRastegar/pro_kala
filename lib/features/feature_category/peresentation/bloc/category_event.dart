part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent extends Equatable{}

class CallCategoryEvent extends CategoryEvent{

  CallCategoryEvent();

  @override
  List<Object?> get props => throw UnimplementedError();

}