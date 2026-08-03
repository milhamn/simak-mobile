import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/krs/domain/usecases/get_krs_usecase.dart';
import 'package:simak_mobile/features/krs/presentation/bloc/krs_event.dart';
import 'package:simak_mobile/features/krs/presentation/bloc/krs_state.dart';

class KrsBloc extends Bloc<KrsEvent, KrsState> {
  final GetKrsUseCase _getKrsUseCase;

  KrsBloc({required GetKrsUseCase getKrsUseCase})
      : _getKrsUseCase = getKrsUseCase,
        super(const KrsState()) {
    on<KrsFetchRequested>(_onKrsFetchRequested);
  }

  Future<void> _onKrsFetchRequested(
    KrsFetchRequested event,
    Emitter<KrsState> emit,
  ) async {
    emit(state.copyWith(status: KrsStatus.loading));
    final result = await _getKrsUseCase.execute();

    if (result is ApiSuccess) {
      final success = result as ApiSuccess;
      emit(state.copyWith(
        status: KrsStatus.success,
        krsItems: success.data,
      ));
    } else {
      emit(state.copyWith(
        status: KrsStatus.failure,
        errorMessage: 'Gagal memuat Kartu Rencana Studi (KRS).',
      ));
    }
  }
}
