import 'package:dio/dio.dart';

class NetworkExceptions {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Koneksi waktu habis. Silakan coba lagi.';
        case DioExceptionType.sendTimeout:
          return 'Waktu pengiriman data habis.';
        case DioExceptionType.receiveTimeout:
          return 'Waktu penerimaan data habis.';
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 401) {
            return 'Sesi telah berakhir. Silakan login kembali.';
          } else if (statusCode == 403) {
            return 'Anda tidak memiliki hak akses.';
          } else if (statusCode == 404) {
            return 'Data tidak ditemukan.';
          } else if (statusCode != null && statusCode >= 500) {
            return 'Terjadi kesalahan pada server universitas.';
          }
          return error.response?.data?['message'] ?? 'Terjadi kesalahan pada server.';
        case DioExceptionType.cancel:
          return 'Permintaan dibatalkan.';
        case DioExceptionType.connectionError:
          return 'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.';
        default:
          return 'Terjadi kesalahan jaringan yang tidak diketahui.';
      }
    }
    return error.toString();
  }
}
