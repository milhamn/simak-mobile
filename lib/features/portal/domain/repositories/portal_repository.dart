import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/portal/domain/entities/portal_info_entity.dart';

abstract class PortalRepository {
  Future<ApiResult<PortalInfoEntity>> getPortalInfo();
}
