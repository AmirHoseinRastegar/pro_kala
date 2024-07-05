part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable{}

class CallAuthEvent extends AuthEvent{
  final String phoneNumber;

  CallAuthEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];


}