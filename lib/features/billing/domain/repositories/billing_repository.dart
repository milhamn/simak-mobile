import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/billing/domain/entities/billing_item_entity.dart';

abstract class BillingRepository {
  Future<ApiResult<List<BillingItemEntity>>> getBillings();
}
