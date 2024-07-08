part of 'token_check_cubit.dart';

@immutable
sealed class TokenCheckState {}

final class TokenCheckInitial extends TokenCheckState {}

final class TokenIsLoggedIn extends TokenCheckState {}

final class TokenIsNotLoggedIn extends TokenCheckState {}
