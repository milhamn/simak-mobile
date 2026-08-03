import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/core/network/dio_client.dart';
import 'package:simak_mobile/core/network/network_exceptions.dart';
import 'package:simak_mobile/features/dashboard/domain/entities/academic_summary_entity.dart';
import 'package:simak_mobile/features/dashboard/domain/entities/announcement_entity.dart';
import 'package:simak_mobile/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DioClient _dioClient;

  DashboardRepositoryImpl(this._dioClient);

  @override
  Future<ApiResult<AcademicSummaryEntity>> getAcademicSummary() async {
    if (EnvConfig.useDummy) {
      await Future.delayed(const Duration(milliseconds: 400));
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

    try {
      final response = await _dioClient.dio.get('/mahasiswa/dashboard');
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as Map<String, dynamic>;
        final summary = data['academic_summary'] as Map<String, dynamic>? ?? {};
        final student = data['student'] as Map<String, dynamic>? ?? {};

        final entity = AcademicSummaryEntity(
          ipk: (summary['gpa'] as num?)?.toDouble() ?? 0.0,
          ips: (summary['ips'] as num?)?.toDouble() ?? 0.0,
          totalSks: (summary['total_sks'] as num?)?.toInt() ?? 0,
          activeSemester: (student['semester'] as num?)?.toInt() ?? 1,
          statusAkademik: student['status']?.toString() ?? 'Aktif',
        );

        return ApiSuccess(entity);
      }
      return ApiFailure(response.data?['message'] ?? 'Gagal memuat ringkasan akademik');
    } catch (e) {
      return ApiFailure(NetworkExceptions.getErrorMessage(e));
    }
  }

  @override
  Future<ApiResult<List<AnnouncementEntity>>> getAnnouncements() async {
    if (EnvConfig.useDummy) {
      await Future.delayed(const Duration(milliseconds: 400));
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

    try {
      final response = await _dioClient.dio.get('/portal/news', queryParameters: {'page': 1, 'limit': 5});
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as Map<String, dynamic>;
        final items = data['items'] as List<dynamic>? ?? [];

        final list = items.map((item) {
          final m = item as Map<String, dynamic>;
          DateTime parsedDate;
          try {
            parsedDate = DateTime.parse(m['published_at'] ?? m['createdAt'] ?? DateTime.now().toIso8601String());
          } catch (_) {
            parsedDate = DateTime.now();
          }

          return AnnouncementEntity(
            id: m['id']?.toString() ?? '',
            title: m['title']?.toString() ?? '',
            content: m['summary']?.toString() ?? m['content']?.toString() ?? '',
            date: parsedDate,
            category: m['category']?.toString() ?? 'Umum',
          );
        }).toList();

        return ApiSuccess(list);
      }
      return ApiFailure(response.data?['message'] ?? 'Gagal memuat pengumuman');
    } catch (e) {
      return ApiFailure(NetworkExceptions.getErrorMessage(e));
    }
  }
}
