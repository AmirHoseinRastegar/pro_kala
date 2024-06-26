part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class CallCategoryEvent extends CategoryEvent{
final   String phoneNumber;

  CallCategoryEvent(this.phoneNumber);

}