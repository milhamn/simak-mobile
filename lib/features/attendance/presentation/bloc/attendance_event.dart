import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class AttendanceFetchRequested extends AttendanceEvent {}

class AttendanceCodeSubmitted extends AttendanceEvent {
  final String code;

  const AttendanceCodeSubmitted(this.code);

  @override
  List<Object?> get props => [code];
}
