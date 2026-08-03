import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/authentication/domain/usecases/get_session_usecase.dart';
import 'package:simak_mobile/features/authentication/domain/usecases/login_usecase.dart';
import 'package:simak_mobile/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_event.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final GetSessionUseCase _getSessionUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required GetSessionUseCase getSessionUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _getSessionUseCase = getSessionUseCase,
        _logoutUseCase = logoutUseCase,
        super(const AuthState()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginSubmitted>(_onAuthLoginSubmitted);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _getSessionUseCase.execute();
    if (result is ApiSuccess) {
      final success = result as ApiSuccess;
      if (success.data != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: success.data,
        ));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> _onAuthLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _loginUseCase.execute(
      identifier: event.identifier,
      password: event.password,
      role: event.role,
    );

    if (result is ApiSuccess) {
      final success = result as ApiSuccess;
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: success.data,
      ));
    } else if (result is ApiFailure) {
      final failure = result as ApiFailure;
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: failure.message,
      ));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutUseCase.execute();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}
