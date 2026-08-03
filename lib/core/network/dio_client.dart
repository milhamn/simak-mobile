import 'package:dio/dio.dart';
import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/storage/secure_storage.dart';

class DioClient {
  late final Dio _dio;
  final SecureStorage _secureStorage;

  DioClient(this._secureStorage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.baseUrl,
        connectTimeout: Duration(milliseconds: EnvConfig.apiTimeout),
        receiveTimeout: Duration(milliseconds: EnvConfig.apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _secureStorage.clearSession();
          }
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
