import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<CallAuthEvent>(_callAuthEventFunc);
  }

  FutureOr<void> _callAuthEventFunc(
      CallAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final String token = await authRepository.fetchAuthApi(event.phoneNumber);

      emit(AuthSuccess(token));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
