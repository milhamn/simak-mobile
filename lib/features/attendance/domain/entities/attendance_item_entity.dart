import 'package:equatable/equatable.dart';

class AttendanceItemEntity extends Equatable {
  final String courseCode;
  final String courseName;
  final int totalMeetings;
  final int attendedMeetings;
  final double percentage;

  const AttendanceItemEntity({
    required this.courseCode,
    required this.courseName,
    required this.totalMeetings,
    required this.attendedMeetings,
    required this.percentage,
  });

  @override
  List<Object?> get props => [courseCode, courseName, totalMeetings, attendedMeetings, percentage];
}
