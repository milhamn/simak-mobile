import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/schedule/domain/usecases/get_schedule_usecase.dart';
import 'package:simak_mobile/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:simak_mobile/features/schedule/presentation/bloc/schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetScheduleUseCase _useCase;

  ScheduleBloc({required GetScheduleUseCase useCase})
      : _useCase = useCase,
        super(const ScheduleState()) {
    on<ScheduleFetchRequested>(_onScheduleFetchRequested);
  }

  Future<void> _onScheduleFetchRequested(
    ScheduleFetchRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    final result = await _useCase.execute();

    if (result is ApiSuccess) {
      final success = result as ApiSuccess;
      emit(state.copyWith(
        status: ScheduleStatus.success,
        schedules: success.data,
      ));
    } else {
      emit(state.copyWith(
        status: ScheduleStatus.failure,
        errorMessage: 'Gagal memuat jadwal perkuliahan.',
      ));
    }
  }
}
