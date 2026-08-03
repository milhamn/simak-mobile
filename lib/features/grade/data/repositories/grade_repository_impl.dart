import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/core/network/dio_client.dart';
import 'package:simak_mobile/core/network/network_exceptions.dart';
import 'package:simak_mobile/features/grade/domain/entities/khs_item_entity.dart';
import 'package:simak_mobile/features/grade/domain/repositories/grade_repository.dart';

class GradeRepositoryImpl implements GradeRepository {
  final DioClient _dioClient;

  GradeRepositoryImpl(this._dioClient);

  @override
  Future<ApiResult<List<KhsItemEntity>>> getKhsBySemester(int semester) async {
    if (EnvConfig.useDummy) {
      await Future.delayed(const Duration(milliseconds: 350));
      final list = [
        const KhsItemEntity(
          courseCode: 'TIF501',
          courseName: 'Pemrograman Mobile Lanjut',
          sks: 3,
          gradeLetter: 'A',
          gradePoint: 4.0,
          lecturerName: 'Dr. Ir. Budi Santoso, M.Kom.',
        ),
        const KhsItemEntity(
          courseCode: 'TIF502',
          courseName: 'Kecerdasan Buatan (AI)',
          sks: 3,
          gradeLetter: 'A-',
          gradePoint: 3.75,
          lecturerName: 'Prof. Dr. Sari Dewi, M.Cs.',
        ),
        const KhsItemEntity(
          courseCode: 'TIF503',
          courseName: 'Rekayasa Perangkat Lunak Enterprise',
          sks: 4,
          gradeLetter: 'B+',
          gradePoint: 3.5,
          lecturerName: 'Ir. Hendra Gunawan, M.T.',
        ),
        const KhsItemEntity(
          courseCode: 'TIF504',
          courseName: 'Keamanan Siber & Kriptografi',
          sks: 3,
          gradeLetter: 'A',
          gradePoint: 4.0,
          lecturerName: 'Dr. Agus Kurniawan, M.Sc.',
        ),
        const KhsItemEntity(
          courseCode: 'TIF505',
          courseName: 'Manajemen Proyek TI',
          sks: 2,
          gradeLetter: 'B+',
          gradePoint: 3.5,
          lecturerName: 'Dra. Wulandari, M.M.',
        ),
      ];
      return ApiSuccess(list);
    }

    try {
      final response = await _dioClient.dio.get(
        '/mahasiswa/khs',
        queryParameters: {'semester': semester.toString()},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as Map<String, dynamic>;
        final grades = data['grades'] as List<dynamic>? ?? [];

        final list = grades.map((g) {
          final m = g as Map<String, dynamic>;
          return KhsItemEntity(
            courseCode: m['course_code']?.toString() ?? '',
            courseName: m['course_name']?.toString() ?? '',
            sks: (m['sks'] as num?)?.toInt() ?? 0,
            gradeLetter: m['grade_letter']?.toString() ?? '-',
            gradePoint: (m['grade_point'] as num?)?.toDouble() ?? 0.0,
            lecturerName: m['lecturer_name']?.toString() ?? '',
          );
        }).toList();

        return ApiSuccess(list);
      }
      return ApiFailure(response.data?['message'] ?? 'Gagal memuat KHS');
    } catch (e) {
      return ApiFailure(NetworkExceptions.getErrorMessage(e));
    }
  }
}
