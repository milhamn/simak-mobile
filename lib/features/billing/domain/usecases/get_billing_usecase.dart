import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/billing/domain/entities/billing_item_entity.dart';
import 'package:simak_mobile/features/billing/domain/repositories/billing_repository.dart';

class GetBillingUseCase {
  final BillingRepository _repository;

  GetBillingUseCase(this._repository);

  Future<ApiResult<List<BillingItemEntity>>> execute() => _repository.getBillings();
}
