import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/portal/domain/entities/portal_info_entity.dart';
import 'package:simak_mobile/features/portal/domain/repositories/portal_repository.dart';

class GetPortalInfoUseCase {
  final PortalRepository repository;

  GetPortalInfoUseCase(this.repository);

  Future<ApiResult<PortalInfoEntity>> execute() async {
    return await repository.getPortalInfo();
  }
}
