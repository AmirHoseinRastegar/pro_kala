part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent extends Equatable{}

class CallCategoryEvent extends CategoryEvent{

  CallCategoryEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}