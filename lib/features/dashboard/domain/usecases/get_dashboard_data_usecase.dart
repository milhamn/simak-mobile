import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/dashboard/domain/entities/academic_summary_entity.dart';
import 'package:simak_mobile/features/dashboard/domain/entities/announcement_entity.dart';
import 'package:simak_mobile/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardDataUseCase {
  final DashboardRepository _repository;

  GetDashboardDataUseCase(this._repository);

  Future<ApiResult<AcademicSummaryEntity>> getSummary() => _repository.getAcademicSummary();
  Future<ApiResult<List<AnnouncementEntity>>> getAnnouncements() => _repository.getAnnouncements();
}
