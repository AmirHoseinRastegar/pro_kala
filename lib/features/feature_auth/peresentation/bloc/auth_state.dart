part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String token;

  AuthSuccess(this.token);
  @override
  // TODO: implement props
  List<Object?> get props => [token];

}

final class AuthError extends AuthState {
  final ExceptionMessage errorMessage;

  AuthError(this.errorMessage);
}
