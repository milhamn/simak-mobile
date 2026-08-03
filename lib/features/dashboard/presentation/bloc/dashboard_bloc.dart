import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:simak_mobile/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:simak_mobile/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardDataUseCase _useCase;

  DashboardBloc({required GetDashboardDataUseCase useCase})
      : _useCase = useCase,
        super(const DashboardState()) {
    on<DashboardFetchRequested>(_onDashboardFetchRequested);
  }

  Future<void> _onDashboardFetchRequested(
    DashboardFetchRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));

    final summaryRes = await _useCase.getSummary();
    final announcementsRes = await _useCase.getAnnouncements();

    if (summaryRes is ApiSuccess && announcementsRes is ApiSuccess) {
      final summarySuccess = summaryRes as ApiSuccess;
      final announcementsSuccess = announcementsRes as ApiSuccess;
      emit(state.copyWith(
        status: DashboardStatus.success,
        summary: summarySuccess.data,
        announcements: announcementsSuccess.data,
      ));
    } else {
      emit(state.copyWith(
        status: DashboardStatus.failure,
        errorMessage: 'Gagal mengambil data dashboard.',
      ));
    }
  }
}
