import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/authentication/domain/entities/user_entity.dart';
import 'package:simak_mobile/features/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<ApiResult<UserEntity>> execute({
    required String identifier,
    required String password,
    required String role,
  }) {
    return _repository.login(
      identifier: identifier,
      password: password,
      role: role,
    );
  }
}
