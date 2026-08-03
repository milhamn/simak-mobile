import 'dart:convert';
import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/core/network/dio_client.dart';
import 'package:simak_mobile/core/network/network_exceptions.dart';
import 'package:simak_mobile/core/storage/secure_storage.dart';
import 'package:simak_mobile/features/authentication/domain/entities/user_entity.dart';
import 'package:simak_mobile/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SecureStorage _secureStorage;
  final DioClient _dioClient;

  AuthRepositoryImpl(this._secureStorage, this._dioClient);

  @override
  Future<ApiResult<UserEntity>> login({
    required String identifier,
    required String password,
    required String role,
  }) async {
    if (EnvConfig.useDummy) {
      await Future.delayed(const Duration(milliseconds: 600));
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

    try {
      final response = await _dioClient.dio.post(
        '/auth/login',
        data: {
          'identifier': identifier,
          'password': password,
          'role': role,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as Map<String, dynamic>;
        final accessToken = data['access_token'] as String;
        final refreshToken = data['refresh_token'] as String?;
        final userMap = data['user'] as Map<String, dynamic>;

        final user = UserEntity(
          id: userMap['id']?.toString() ?? '',
          name: userMap['name']?.toString() ?? '',
          identifier: userMap['identifier']?.toString() ?? identifier,
          role: userMap['role']?.toString().toLowerCase() ?? role,
          email: userMap['email']?.toString() ?? '',
          programStudi: userMap['program_studi']?.toString() ?? userMap['programStudi']?.toString() ?? '',
          avatarUrl: userMap['avatar_url']?.toString(),
        );

        await _secureStorage.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken ?? '',
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

        return ApiSuccess(user, message: response.data['message'] ?? 'Berhasil login');
      }

      return ApiFailure(response.data?['message'] ?? 'Gagal melakukan login');
    } catch (e) {
      return ApiFailure(NetworkExceptions.getErrorMessage(e));
    }
  }

  @override
  Future<ApiResult<UserEntity?>> getSavedSession() async {
    try {
      final token = await _secureStorage.getAccessToken();
      final userDataStr = await _secureStorage.getUserData();

      if (token != null && userDataStr != null) {
        final map = jsonDecode(userDataStr) as Map<String, dynamic>;
        final user = UserEntity(
          id: map['id']?.toString() ?? '',
          name: map['name']?.toString() ?? '',
          identifier: map['identifier']?.toString() ?? '',
          role: map['role']?.toString() ?? '',
          email: map['email']?.toString() ?? '',
          programStudi: map['programStudi']?.toString() ?? '',
          avatarUrl: map['avatarUrl']?.toString(),
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
    if (!EnvConfig.useDummy) {
      try {
        final token = await _secureStorage.getAccessToken();
        if (token != null && token.isNotEmpty) {
          await _dioClient.dio.post('/auth/logout');
        }
      } catch (_) {}
    }
    await _secureStorage.clearSession();
  }
}
