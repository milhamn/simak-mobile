import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/attendance/domain/entities/attendance_item_entity.dart';
import 'package:simak_mobile/features/attendance/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  @override
  Future<ApiResult<List<AttendanceItemEntity>>> getAttendanceSummary() async {
    await Future.delayed(const Duration(milliseconds: 350));
    if (EnvConfig.useDummy) {
      final list = [
        const AttendanceItemEntity(
          courseCode: 'TIF501',
          courseName: 'Pemrograman Mobile Lanjut',
          totalMeetings: 14,
          attendedMeetings: 14,
          percentage: 100.0,
        ),
        const AttendanceItemEntity(
          courseCode: 'TIF502',
          courseName: 'Kecerdasan Buatan (AI)',
          totalMeetings: 14,
          attendedMeetings: 13,
          percentage: 92.8,
        ),
        const AttendanceItemEntity(
          courseCode: 'TIF503',
          courseName: 'Rekayasa Perangkat Lunak Enterprise',
          totalMeetings: 14,
          attendedMeetings: 12,
          percentage: 85.7,
        ),
        const AttendanceItemEntity(
          courseCode: 'TIF504',
          courseName: 'Keamanan Siber & Kriptografi',
          totalMeetings: 14,
          attendedMeetings: 14,
          percentage: 100.0,
        ),
        const AttendanceItemEntity(
          courseCode: 'TIF505',
          courseName: 'Manajemen Proyek TI',
          totalMeetings: 14,
          attendedMeetings: 13,
          percentage: 92.8,
        ),
      ];
      return ApiSuccess(list);
    }
    return const ApiFailure('Server API tidak tersedia');
  }

  @override
  Future<ApiResult<bool>> submitAttendanceCode(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (code.trim().toUpperCase() == 'SIMAK2026' || code.length >= 4) {
      return const ApiSuccess(true, message: 'Presensi berhasil dicatat.');
    }
    return const ApiFailure('Kode presensi tidak valid atau telah kadaluarsa.');
  }
}
