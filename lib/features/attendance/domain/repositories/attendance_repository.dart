import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/attendance/domain/entities/attendance_item_entity.dart';

abstract class AttendanceRepository {
  Future<ApiResult<List<AttendanceItemEntity>>> getAttendanceSummary();
  Future<ApiResult<bool>> submitAttendanceCode(String code);
}
