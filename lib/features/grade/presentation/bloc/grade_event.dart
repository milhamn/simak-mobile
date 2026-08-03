import 'package:equatable/equatable.dart';

abstract class GradeEvent extends Equatable {
  const GradeEvent();

  @override
  List<Object?> get props => [];
}

class GradeFetchKhsRequested extends GradeEvent {
  final int semester;

  const GradeFetchKhsRequested(this.semester);

  @override
  List<Object?> get props => [semester];
}
