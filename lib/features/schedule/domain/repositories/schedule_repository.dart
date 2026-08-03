import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/schedule/domain/entities/schedule_entity.dart';

abstract class ScheduleRepository {
  Future<ApiResult<List<ScheduleEntity>>> getSchedules();
}
