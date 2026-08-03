import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/grade/domain/entities/khs_item_entity.dart';
import 'package:simak_mobile/features/grade/domain/repositories/grade_repository.dart';

class GradeRepositoryImpl implements GradeRepository {
  @override
  Future<ApiResult<List<KhsItemEntity>>> getKhsBySemester(int semester) async {
    await Future.delayed(const Duration(milliseconds: 350));
    if (EnvConfig.useDummy) {
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
    return const ApiFailure('Server API tidak tersedia');
  }
}
