import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginSubmitted extends AuthEvent {
  final String identifier;
  final String password;
  final String role;

  const AuthLoginSubmitted({
    required this.identifier,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [identifier, password, role];
}

class AuthLogoutRequested extends AuthEvent {}
