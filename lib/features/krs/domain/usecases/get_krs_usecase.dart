import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/krs/domain/entities/krs_item_entity.dart';
import 'package:simak_mobile/features/krs/domain/repositories/krs_repository.dart';

class GetKrsUseCase {
  final KrsRepository _repository;

  GetKrsUseCase(this._repository);

  Future<ApiResult<List<KrsItemEntity>>> execute() => _repository.getActiveKrs();
}
