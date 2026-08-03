import 'package:equatable/equatable.dart';

class KrsItemEntity extends Equatable {
  final String courseCode;
  final String courseName;
  final int sks;
  final String classGroup;
  final String scheduleTime;
  final String statusApproval; // 'Disetujui', 'Menunggu', 'Ditolak'

  const KrsItemEntity({
    required this.courseCode,
    required this.courseName,
    required this.sks,
    required this.classGroup,
    required this.scheduleTime,
    required this.statusApproval,
  });

  @override
  List<Object?> get props => [courseCode, courseName, sks, classGroup, scheduleTime, statusApproval];
}
