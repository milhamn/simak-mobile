import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/dashboard/domain/entities/academic_summary_entity.dart';
import 'package:simak_mobile/features/dashboard/domain/entities/announcement_entity.dart';
import 'package:simak_mobile/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<ApiResult<AcademicSummaryEntity>> getAcademicSummary() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (EnvConfig.useDummy) {
      return const ApiSuccess(
        AcademicSummaryEntity(
          ipk: 3.82,
          ips: 3.90,
          totalSks: 84,
          activeSemester: 5,
          statusAkademik: 'Aktif',
        ),
      );
    }
    return const ApiFailure('Server API tidak tersedia');
  }

  @override
  Future<ApiResult<List<AnnouncementEntity>>> getAnnouncements() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (EnvConfig.useDummy) {
      final list = [
        AnnouncementEntity(
          id: 'ANN-01',
          title: 'Jadwal Pengisian KRS Semester Ganjil 2026/2027',
          content: 'Pengisian KRS dibuka mulai tanggal 1 s/d 15 Agustus 2026 melalui aplikasi SIMAK Mobile.',
          date: DateTime.now().subtract(const Duration(days: 1)),
          category: 'Akademik',
        ),
        AnnouncementEntity(
          id: 'ANN-02',
          title: 'Pembayaran UKT Tahap II TA 2026',
          content: 'Batas akhir pembayaran UKT Tahap II adalah 10 Agustus 2026 melalui Virtual Account BNI/Mandiri.',
          date: DateTime.now().subtract(const Duration(days: 3)),
          category: 'Keuangan',
        ),
        AnnouncementEntity(
          id: 'ANN-03',
          title: 'Seminar Nasional Teknologi Informasi & AI',
          content: 'Program Studi Informatika mengadakan Seminar Nasional AI pada tanggal 25 Agustus 2026.',
          date: DateTime.now().subtract(const Duration(days: 5)),
          category: 'Umum',
        ),
      ];
      return ApiSuccess(list);
    }
    return const ApiFailure('Server API tidak tersedia');
  }
}
