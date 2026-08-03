import 'package:equatable/equatable.dart';
import 'package:simak_mobile/features/attendance/domain/entities/attendance_item_entity.dart';

enum AttendanceStatus { initial, loading, success, failure, submitting, submitSuccess }

class AttendanceState extends Equatable {
  final AttendanceStatus status;
  final List<AttendanceItemEntity> attendanceItems;
  final String? errorMessage;
  final String? successMessage;

  const AttendanceState({
    this.status = AttendanceStatus.initial,
    this.attendanceItems = const [],
    this.errorMessage,
    this.successMessage,
  });

  AttendanceState copyWith({
    AttendanceStatus? status,
    List<AttendanceItemEntity>? attendanceItems,
    String? errorMessage,
    String? successMessage,
  }) {
    return AttendanceState(
      status: status ?? this.status,
      attendanceItems: attendanceItems ?? this.attendanceItems,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [status, attendanceItems, errorMessage, successMessage];
}
