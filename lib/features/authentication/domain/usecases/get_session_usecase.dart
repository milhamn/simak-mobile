import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/authentication/domain/entities/user_entity.dart';
import 'package:simak_mobile/features/authentication/domain/repositories/auth_repository.dart';

class GetSessionUseCase {
  final AuthRepository _repository;

  GetSessionUseCase(this._repository);

  Future<ApiResult<UserEntity?>> execute() {
    return _repository.getSavedSession();
  }
}
