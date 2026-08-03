import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/billing/domain/entities/billing_item_entity.dart';
import 'package:simak_mobile/features/billing/domain/repositories/billing_repository.dart';

class BillingRepositoryImpl implements BillingRepository {
  @override
  Future<ApiResult<List<BillingItemEntity>>> getBillings() async {
    await Future.delayed(const Duration(milliseconds: 350));
    if (EnvConfig.useDummy) {
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
    return const ApiFailure('Server API tidak tersedia');
  }
}
