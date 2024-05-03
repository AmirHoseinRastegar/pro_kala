part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final HomeModel homeModel;



  HomeSuccess(this.homeModel);
}

final class HomeError extends HomeState {
  final String exceptionMessage;

  HomeError(this.exceptionMessage);

  @override
  List<Object?> get props => [exceptionMessage];
}
