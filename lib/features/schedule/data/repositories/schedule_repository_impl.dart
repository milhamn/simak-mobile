import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/schedule/domain/entities/schedule_entity.dart';
import 'package:simak_mobile/features/schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  @override
  Future<ApiResult<List<ScheduleEntity>>> getSchedules() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (EnvConfig.useDummy) {
      final schedules = [
        const ScheduleEntity(
          id: 'SCH-01',
          courseCode: 'TIF501',
          courseName: 'Pemrograman Mobile Lanjut',
          sks: 3,
          day: 'Senin',
          timeStart: '08:00',
          timeEnd: '10:30',
          room: 'Lab Komputer 3',
          lecturerName: 'Dr. Ir. Budi Santoso, M.Kom.',
          classGroup: 'TI-5A',
        ),
        const ScheduleEntity(
          id: 'SCH-02',
          courseCode: 'TIF502',
          courseName: 'Kecerdasan Buatan (AI)',
          sks: 3,
          day: 'Senin',
          timeStart: '10:45',
          timeEnd: '13:15',
          room: 'R. 402 Gedung A',
          lecturerName: 'Prof. Dr. Ir. Herman, M.Sc.',
          classGroup: 'TI-5A',
        ),
        const ScheduleEntity(
          id: 'SCH-03',
          courseCode: 'TIF503',
          courseName: 'Rekayasa Perangkat Lunak Enterprise',
          sks: 4,
          day: 'Selasa',
          timeStart: '08:00',
          timeEnd: '11:30',
          room: 'R. 305 Gedung B',
          lecturerName: 'Drs. Suparno, M.T.',
          classGroup: 'TI-5A',
        ),
        const ScheduleEntity(
          id: 'SCH-04',
          courseCode: 'TIF504',
          courseName: 'Keamanan Siber & Kriptografi',
          sks: 3,
          day: 'Rabu',
          timeStart: '13:30',
          timeEnd: '16:00',
          room: 'Lab Jaringan Gedung C',
          lecturerName: 'Rina Wijaya, S.Kom., M.T.',
          classGroup: 'TI-5A',
        ),
        const ScheduleEntity(
          id: 'SCH-05',
          courseCode: 'TIF505',
          courseName: 'Manajemen Proyek TI',
          sks: 2,
          day: 'Kamis',
          timeStart: '10:00',
          timeEnd: '11:40',
          room: 'R. 201 Gedung A',
          lecturerName: 'Dr. Ir. Budi Santoso, M.Kom.',
          classGroup: 'TI-5A',
        ),
        const ScheduleEntity(
          id: 'SCH-06',
          courseCode: 'TIF506',
          courseName: 'Pengolahan Citra Digital',
          sks: 3,
          day: 'Jumat',
          timeStart: '08:30',
          timeEnd: '11:00',
          room: 'Lab Komputer 2',
          lecturerName: 'Dr. Hendra Gunawan, M.Si.',
          classGroup: 'TI-5A',
        ),
      ];
      return ApiSuccess(schedules);
    }
    return const ApiFailure('Server API tidak tersedia');
  }
}
