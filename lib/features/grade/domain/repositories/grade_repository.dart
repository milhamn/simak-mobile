import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/grade/domain/entities/khs_item_entity.dart';

abstract class GradeRepository {
  Future<ApiResult<List<KhsItemEntity>>> getKhsBySemester(int semester);
}
