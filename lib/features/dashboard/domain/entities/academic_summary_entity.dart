import 'package:equatable/equatable.dart';

class AcademicSummaryEntity extends Equatable {
  final double ipk;
  final double ips;
  final int totalSks;
  final int activeSemester;
  final String statusAkademik; // 'Aktif', 'Cuti', etc.

  const AcademicSummaryEntity({
    required this.ipk,
    required this.ips,
    required this.totalSks,
    required this.activeSemester,
    required this.statusAkademik,
  });

  @override
  List<Object?> get props => [ipk, ips, totalSks, activeSemester, statusAkademik];
}
