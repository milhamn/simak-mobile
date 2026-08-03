import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/grade/domain/entities/khs_item_entity.dart';
import 'package:simak_mobile/features/grade/domain/repositories/grade_repository.dart';

class GetKhsUseCase {
  final GradeRepository _repository;

  GetKhsUseCase(this._repository);

  Future<ApiResult<List<KhsItemEntity>>> execute(int semester) => _repository.getKhsBySemester(semester);
}
