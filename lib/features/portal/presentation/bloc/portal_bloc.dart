import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/portal/domain/usecases/get_portal_info_usecase.dart';
import 'package:simak_mobile/features/portal/presentation/bloc/portal_event.dart';
import 'package:simak_mobile/features/portal/presentation/bloc/portal_state.dart';

class PortalBloc extends Bloc<PortalEvent, PortalState> {
  final GetPortalInfoUseCase useCase;

  PortalBloc({required this.useCase}) : super(const PortalState()) {
    on<PortalFetchRequested>(_onPortalFetchRequested);
  }

  Future<void> _onPortalFetchRequested(
    PortalFetchRequested event,
    Emitter<PortalState> emit,
  ) async {
    emit(state.copyWith(status: PortalStatus.loading));
    final result = await useCase.execute();

    if (result is ApiSuccess) {
      emit(state.copyWith(
        status: PortalStatus.success,
        portalInfo: (result as ApiSuccess).data,
      ));
    } else if (result is ApiFailure) {
      emit(state.copyWith(
        status: PortalStatus.failure,
        errorMessage: (result as ApiFailure).message,
      ));
    }
  }
}
