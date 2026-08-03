import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/core/network/dio_client.dart';
import 'package:simak_mobile/core/network/network_exceptions.dart';
import 'package:simak_mobile/features/attendance/domain/entities/attendance_item_entity.dart';
import 'package:simak_mobile/features/attendance/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final DioClient _dioClient;

  AttendanceRepositoryImpl(this._dioClient);

  @override
  Future<ApiResult<List<AttendanceItemEntity>>> getAttendanceSummary() async {
    if (EnvConfig.useDummy) {
      await Future.delayed(const Duration(milliseconds: 350));
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

    try {
      final response = await _dioClient.dio.get('/mahasiswa/presensi/recap');
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as Map<String, dynamic>;
        final courses = data['courses'] as List<dynamic>? ?? [];

        final list = courses.map((c) {
          final m = c as Map<String, dynamic>;
          return AttendanceItemEntity(
            courseCode: m['course_code']?.toString() ?? '',
            courseName: m['course_name']?.toString() ?? '',
            totalMeetings: (m['total_meetings'] as num?)?.toInt() ?? 14,
            attendedMeetings: (m['attended_meetings'] as num?)?.toInt() ?? 0,
            percentage: (m['percentage'] as num?)?.toDouble() ?? 0.0,
          );
        }).toList();

        return ApiSuccess(list);
      }
      return ApiFailure(response.data?['message'] ?? 'Gagal memuat rekap presensi');
    } catch (e) {
      return ApiFailure(NetworkExceptions.getErrorMessage(e));
    }
  }

  @override
  Future<ApiResult<bool>> submitAttendanceCode(String code) async {
    if (EnvConfig.useDummy) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (code.trim().toUpperCase() == 'SIMAK2026' || code.length >= 4) {
        return const ApiSuccess(true, message: 'Presensi berhasil dicatat.');
      }
      return const ApiFailure('Kode presensi tidak valid atau telah kadaluarsa.');
    }

    try {
      final response = await _dioClient.dio.post(
        '/mahasiswa/presensi/submit',
        data: {'session_code': code},
      );

      if (response.statusCode == 200) {
        return ApiSuccess(true, message: response.data?['message'] ?? 'Presensi berhasil dicatat.');
      }
      return ApiFailure(response.data?['message'] ?? 'Gagal mencatat presensi');
    } catch (e) {
      return ApiFailure(NetworkExceptions.getErrorMessage(e));
    }
  }
}
