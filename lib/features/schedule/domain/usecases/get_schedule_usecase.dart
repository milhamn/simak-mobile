import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/schedule/domain/entities/schedule_entity.dart';
import 'package:simak_mobile/features/schedule/domain/repositories/schedule_repository.dart';

class GetScheduleUseCase {
  final ScheduleRepository _repository;

  GetScheduleUseCase(this._repository);

  Future<ApiResult<List<ScheduleEntity>>> execute() => _repository.getSchedules();
}
