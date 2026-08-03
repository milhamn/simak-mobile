import 'package:equatable/equatable.dart';

class StudentEnrollmentEntity extends Equatable {
  final String nim;
  final String name;
  final String programStudi;
  final String avatarUrl;

  const StudentEnrollmentEntity({
    required this.nim,
    required this.name,
    required this.programStudi,
    this.avatarUrl = '',
  });

  @override
  List<Object?> get props => [nim, name, programStudi];
}
