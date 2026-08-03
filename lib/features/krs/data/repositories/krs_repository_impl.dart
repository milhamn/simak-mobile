import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/krs/domain/entities/krs_item_entity.dart';
import 'package:simak_mobile/features/krs/domain/repositories/krs_repository.dart';

class KrsRepositoryImpl implements KrsRepository {
  @override
  Future<ApiResult<List<KrsItemEntity>>> getActiveKrs() async {
    await Future.delayed(const Duration(milliseconds: 350));
    if (EnvConfig.useDummy) {
      final list = [
        const KrsItemEntity(
          courseCode: 'TIF501',
          courseName: 'Pemrograman Mobile Lanjut',
          sks: 3,
          classGroup: 'TI-5A',
          scheduleTime: 'Senin, 08:00 - 10:30',
          statusApproval: 'Disetujui',
        ),
        const KrsItemEntity(
          courseCode: 'TIF502',
          courseName: 'Kecerdasan Buatan (AI)',
          sks: 3,
          classGroup: 'TI-5A',
          scheduleTime: 'Senin, 10:45 - 13:15',
          statusApproval: 'Disetujui',
        ),
        const KrsItemEntity(
          courseCode: 'TIF503',
          courseName: 'Rekayasa Perangkat Lunak Enterprise',
          sks: 4,
          classGroup: 'TI-5A',
          scheduleTime: 'Selasa, 08:00 - 11:30',
          statusApproval: 'Disetujui',
        ),
        const KrsItemEntity(
          courseCode: 'TIF504',
          courseName: 'Keamanan Siber & Kriptografi',
          sks: 3,
          classGroup: 'TI-5A',
          scheduleTime: 'Rabu, 13:30 - 16:00',
          statusApproval: 'Disetujui',
        ),
        const KrsItemEntity(
          courseCode: 'TIF505',
          courseName: 'Manajemen Proyek TI',
          sks: 2,
          classGroup: 'TI-5A',
          scheduleTime: 'Kamis, 10:00 - 11:40',
          statusApproval: 'Disetujui',
        ),
        const KrsItemEntity(
          courseCode: 'TIF506',
          courseName: 'Pengolahan Citra Digital',
          sks: 3,
          classGroup: 'TI-5A',
          scheduleTime: 'Jumat, 08:30 - 11:00',
          statusApproval: 'Disetujui',
        ),
      ];
      return ApiSuccess(list);
    }
    return const ApiFailure('Server API tidak tersedia');
  }
}
