import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/grade/domain/usecases/get_khs_usecase.dart';
import 'package:simak_mobile/features/grade/presentation/bloc/grade_event.dart';
import 'package:simak_mobile/features/grade/presentation/bloc/grade_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  final GetKhsUseCase _getKhsUseCase;

  GradeBloc({required GetKhsUseCase getKhsUseCase})
      : _getKhsUseCase = getKhsUseCase,
        super(const GradeState()) {
    on<GradeFetchKhsRequested>(_onGradeFetchKhsRequested);
  }

  Future<void> _onGradeFetchKhsRequested(
    GradeFetchKhsRequested event,
    Emitter<GradeState> emit,
  ) async {
    emit(state.copyWith(status: GradeStatus.loading, selectedSemester: event.semester));
    final result = await _getKhsUseCase.execute(event.semester);

    if (result is ApiSuccess) {
      final success = result as ApiSuccess;
      emit(state.copyWith(
        status: GradeStatus.success,
        khsItems: success.data,
      ));
    } else {
      emit(state.copyWith(
        status: GradeStatus.failure,
        errorMessage: 'Gagal memuat nilai KHS.',
      ));
    }
  }
}
