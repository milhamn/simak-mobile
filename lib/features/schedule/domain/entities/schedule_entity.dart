import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  final String id;
  final String courseCode;
  final String courseName;
  final int sks;
  final String day; // 'Senin', 'Selasa', etc.
  final String timeStart;
  final String timeEnd;
  final String room;
  final String lecturerName;
  final String classGroup;

  const ScheduleEntity({
    required this.id,
    required this.courseCode,
    required this.courseName,
    required this.sks,
    required this.day,
    required this.timeStart,
    required this.timeEnd,
    required this.room,
    required this.lecturerName,
    required this.classGroup,
  });

  @override
  List<Object?> get props => [id, courseCode, courseName, sks, day, timeStart, timeEnd, room, lecturerName, classGroup];
}
