import 'package:equatable/equatable.dart';
import 'package:simak_mobile/features/dashboard/domain/entities/academic_summary_entity.dart';
import 'package:simak_mobile/features/dashboard/domain/entities/announcement_entity.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final AcademicSummaryEntity? summary;
  final List<AnnouncementEntity> announcements;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.summary,
    this.announcements = const [],
    this.errorMessage,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    AcademicSummaryEntity? summary,
    List<AnnouncementEntity>? announcements,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      announcements: announcements ?? this.announcements,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, summary, announcements, errorMessage];
}
