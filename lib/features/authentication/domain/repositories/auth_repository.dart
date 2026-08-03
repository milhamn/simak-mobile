import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<ApiResult<UserEntity>> login({
    required String identifier,
    required String password,
    required String role,
  });

  Future<ApiResult<UserEntity?>> getSavedSession();

  Future<void> logout();
}
