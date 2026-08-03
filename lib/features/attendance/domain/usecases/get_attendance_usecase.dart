import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/attendance/domain/entities/attendance_item_entity.dart';
import 'package:simak_mobile/features/attendance/domain/repositories/attendance_repository.dart';

class GetAttendanceUseCase {
  final AttendanceRepository _repository;

  GetAttendanceUseCase(this._repository);

  Future<ApiResult<List<AttendanceItemEntity>>> getSummary() => _repository.getAttendanceSummary();
  Future<ApiResult<bool>> submitCode(String code) => _repository.submitAttendanceCode(code);
}
