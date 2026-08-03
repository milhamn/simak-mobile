import 'package:equatable/equatable.dart';
import '../../domain/entities/krs_item_entity.dart';

enum KrsStatus { initial, loading, success, failure }

class KrsState extends Equatable {
  final KrsStatus status;
  final List<KrsItemEntity> krsItems;
  final int maxSks;
  final String dpaName;
  final String? errorMessage;

  const KrsState({
    this.status = KrsStatus.initial,
    this.krsItems = const [],
    this.maxSks = 24,
    this.dpaName = 'Dr. Ir. Budi Santoso, M.Kom.',
    this.errorMessage,
  });

  int get totalSksTaken {
    int total = 0;
    for (var item in krsItems) {
      total += item.sks;
    }
    return total;
  }

  KrsState copyWith({
    KrsStatus? status,
    List<KrsItemEntity>? krsItems,
    int? maxSks,
    String? dpaName,
    String? errorMessage,
  }) {
    return KrsState(
      status: status ?? this.status,
      krsItems: krsItems ?? this.krsItems,
      maxSks: maxSks ?? this.maxSks,
      dpaName: dpaName ?? this.dpaName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, krsItems, maxSks, dpaName, errorMessage];
}
