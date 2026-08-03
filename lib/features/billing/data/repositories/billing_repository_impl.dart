import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/core/network/dio_client.dart';
import 'package:simak_mobile/core/network/network_exceptions.dart';
import 'package:simak_mobile/features/billing/domain/entities/billing_item_entity.dart';
import 'package:simak_mobile/features/billing/domain/repositories/billing_repository.dart';

class BillingRepositoryImpl implements BillingRepository {
  final DioClient _dioClient;

  BillingRepositoryImpl(this._dioClient);

  @override
  Future<ApiResult<List<BillingItemEntity>>> getBillings() async {
    if (EnvConfig.useDummy) {
      await Future.delayed(const Duration(milliseconds: 350));
      final list = [
        BillingItemEntity(
          id: 'BILL-01',
          title: 'UKT / SPP Semester Ganjil 2026/2027',
          amount: 4500000,
          dueDate: DateTime.now().add(const Duration(days: 15)),
          status: 'Belum Lunas',
          virtualAccount: '988001220512044',
        ),
        BillingItemEntity(
          id: 'BILL-02',
          title: 'Biaya Praktikum Lab Komputer',
          amount: 500000,
          dueDate: DateTime.now().subtract(const Duration(days: 30)),
          status: 'Lunas',
          virtualAccount: '988001220512044',
        ),
        BillingItemEntity(
          id: 'BILL-03',
          title: 'UKT / SPP Semester Genap 2025/2026',
          amount: 4500000,
          dueDate: DateTime.now().subtract(const Duration(days: 180)),
          status: 'Lunas',
          virtualAccount: '988001220512044',
        ),
      ];
      return ApiSuccess(list);
    }

    try {
      final response = await _dioClient.dio.get('/mahasiswa/tagihan');
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as Map<String, dynamic>;
        final invoices = data['invoices'] as List<dynamic>? ?? [];

        final list = invoices.map((inv) {
          final m = inv as Map<String, dynamic>;
          DateTime dueDate;
          try {
            dueDate = DateTime.parse(m['due_date'] ?? DateTime.now().toIso8601String());
          } catch (_) {
            dueDate = DateTime.now();
          }

          return BillingItemEntity(
            id: m['id']?.toString() ?? '',
            title: m['invoice_number'] != null ? 'Tagihan ${m['invoice_number']}' : 'Tagihan Pembayaran Kuliah',
            amount: (m['amount'] as num?)?.toDouble() ?? 0.0,
            dueDate: dueDate,
            status: m['status']?.toString() ?? 'Belum Lunas',
            virtualAccount: m['virtual_account_no']?.toString() ?? '-',
          );
        }).toList();

        return ApiSuccess(list);
      }
      return ApiFailure(response.data?['message'] ?? 'Gagal memuat daftar tagihan');
    } catch (e) {
      return ApiFailure(NetworkExceptions.getErrorMessage(e));
    }
  }
}
