import 'package:equatable/equatable.dart';

class LecturerCourseEntity extends Equatable {
  final String id;
  final String courseCode;
  final String courseName;
  final int sks;
  final String classGroup;
  final String totalStudents;
  final String day;
  final String timeStart;
  final String timeEnd;
  final String room;
  final int pertemuanKe;
  final int totalPertemuan;

  const LecturerCourseEntity({
    required this.id,
    required this.courseCode,
    required this.courseName,
    required this.sks,
    required this.classGroup,
    required this.totalStudents,
    this.day = '-',
    this.timeStart = '-',
    this.timeEnd = '-',
    this.room = '-',
    this.pertemuanKe = 1,
    this.totalPertemuan = 16,
  });

  @override
  List<Object?> get props => [id, courseCode, courseName, sks, classGroup, totalStudents];
}
