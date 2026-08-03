import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/dashboard/domain/entities/academic_summary_entity.dart';
import 'package:simak_mobile/features/dashboard/domain/entities/announcement_entity.dart';

abstract class DashboardRepository {
  Future<ApiResult<AcademicSummaryEntity>> getAcademicSummary();
  Future<ApiResult<List<AnnouncementEntity>>> getAnnouncements();
}
