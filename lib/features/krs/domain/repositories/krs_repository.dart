import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/krs/domain/entities/krs_item_entity.dart';

abstract class KrsRepository {
  Future<ApiResult<List<KrsItemEntity>>> getActiveKrs();
}
