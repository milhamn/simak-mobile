import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String identifier; // NIM or NIDN
  final String role; // 'mahasiswa' or 'dosen'
  final String email;
  final String programStudi;
  final String? avatarUrl;

  const UserEntity({
    required this.id,
    required this.name,
    required this.identifier,
    required this.role,
    required this.email,
    required this.programStudi,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, identifier, role, email, programStudi, avatarUrl];
}
