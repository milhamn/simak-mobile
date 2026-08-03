import 'dart:convert';
import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/core/storage/secure_storage.dart';
import 'package:simak_mobile/features/authentication/domain/entities/user_entity.dart';
import 'package:simak_mobile/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SecureStorage _secureStorage;

  AuthRepositoryImpl(this._secureStorage);

  @override
  Future<ApiResult<UserEntity>> login({
    required String identifier,
    required String password,
    required String role,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (EnvConfig.useDummy) {
      if (password.length < 4) {
        return const ApiFailure('Kata sandi minimal 4 karakter');
      }

      final UserEntity user;
      if (role == 'dosen') {
        user = UserEntity(
          id: 'DSN-001',
          name: 'Dr. Ir. Budi Santoso, M.Kom.',
          identifier: identifier.isEmpty ? '210512001' : identifier,
          role: 'dosen',
          email: 'budi.santoso@methodist.ac.id',
          programStudi: 'Teknik Informatika',
          avatarUrl: 'https://i.pravatar.cc/300?img=11',
        );
      } else {
        user = UserEntity(
          id: 'MHS-001',
          name: 'M. Ilham Nurdiansyah',
          identifier: identifier.isEmpty ? '220512044' : identifier,
          role: 'mahasiswa',
          email: 'ilham.nurdiansyah@student.methodist.ac.id',
          programStudi: 'S1 Teknik Informatika',
          avatarUrl: 'https://i.pravatar.cc/300?img=12',
        );
      }

      await _secureStorage.saveTokens(
        accessToken: 'mock_jwt_access_token_${user.id}',
        refreshToken: 'mock_jwt_refresh_token_${user.id}',
      );
      final jsonMap = {
        'id': user.id,
        'name': user.name,
        'identifier': user.identifier,
        'role': user.role,
        'email': user.email,
        'programStudi': user.programStudi,
        'avatarUrl': user.avatarUrl,
      };
      await _secureStorage.saveUserData(jsonEncode(jsonMap));

      return ApiSuccess(user, message: 'Berhasil login');
    }

    return const ApiFailure('Koneksi server API sesungguhnya belum dikonfigurasi.');
  }

  @override
  Future<ApiResult<UserEntity?>> getSavedSession() async {
    try {
      final token = await _secureStorage.getAccessToken();
      final userDataStr = await _secureStorage.getUserData();

      if (token != null && userDataStr != null) {
        final map = jsonDecode(userDataStr) as Map<String, dynamic>;
        final user = UserEntity(
          id: map['id'],
          name: map['name'],
          identifier: map['identifier'],
          role: map['role'],
          email: map['email'],
          programStudi: map['programStudi'],
          avatarUrl: map['avatarUrl'],
        );
        return ApiSuccess(user);
      }
      return const ApiSuccess(null);
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await _secureStorage.clearSession();
  }
}
