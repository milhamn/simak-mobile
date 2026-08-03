import 'package:equatable/equatable.dart';

class KhsItemEntity extends Equatable {
  final String courseCode;
  final String courseName;
  final int sks;
  final String gradeLetter; // 'A', 'B+', 'B', 'C+', 'C'
  final double gradePoint; // 4.0, 3.5, 3.0, 2.5, 2.0
  final String lecturerName; // Nama dosen pengampu

  const KhsItemEntity({
    required this.courseCode,
    required this.courseName,
    required this.sks,
    required this.gradeLetter,
    required this.gradePoint,
    this.lecturerName = '-',
  });

  @override
  List<Object?> get props => [courseCode, courseName, sks, gradeLetter, gradePoint, lecturerName];
}
