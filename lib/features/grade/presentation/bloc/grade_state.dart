import 'package:equatable/equatable.dart';
import 'package:simak_mobile/features/grade/domain/entities/khs_item_entity.dart';

enum GradeStatus { initial, loading, success, failure }

class GradeState extends Equatable {
  final GradeStatus status;
  final int selectedSemester;
  final List<KhsItemEntity> khsItems;
  final String? errorMessage;

  const GradeState({
    this.status = GradeStatus.initial,
    this.selectedSemester = 5,
    this.khsItems = const [],
    this.errorMessage,
  });

  double get calculatedIps {
    if (khsItems.isEmpty) return 0.0;
    double totalPoints = 0;
    int totalSks = 0;
    for (var item in khsItems) {
      totalPoints += (item.gradePoint * item.sks);
      totalSks += item.sks;
    }
    return totalSks == 0 ? 0.0 : totalPoints / totalSks;
  }

  int get totalSks {
    int total = 0;
    for (var item in khsItems) {
      total += item.sks;
    }
    return total;
  }

  GradeState copyWith({
    GradeStatus? status,
    int? selectedSemester,
    List<KhsItemEntity>? khsItems,
    String? errorMessage,
  }) {
    return GradeState(
      status: status ?? this.status,
      selectedSemester: selectedSemester ?? this.selectedSemester,
      khsItems: khsItems ?? this.khsItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, selectedSemester, khsItems, errorMessage];
}
