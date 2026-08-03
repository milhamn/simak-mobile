import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/attendance/domain/usecases/get_attendance_usecase.dart';
import 'package:simak_mobile/features/attendance/presentation/bloc/attendance_event.dart';
import 'package:simak_mobile/features/attendance/presentation/bloc/attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final GetAttendanceUseCase _useCase;

  AttendanceBloc({required GetAttendanceUseCase useCase})
      : _useCase = useCase,
        super(const AttendanceState()) {
    on<AttendanceFetchRequested>(_onAttendanceFetchRequested);
    on<AttendanceCodeSubmitted>(_onAttendanceCodeSubmitted);
  }

  Future<void> _onAttendanceFetchRequested(
    AttendanceFetchRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(status: AttendanceStatus.loading));
    final result = await _useCase.getSummary();

    if (result is ApiSuccess) {
      final success = result as ApiSuccess;
      emit(state.copyWith(
        status: AttendanceStatus.success,
        attendanceItems: success.data,
      ));
    } else {
      emit(state.copyWith(
        status: AttendanceStatus.failure,
        errorMessage: 'Gagal memuat rekapitulasi presensi.',
      ));
    }
  }

  Future<void> _onAttendanceCodeSubmitted(
    AttendanceCodeSubmitted event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(status: AttendanceStatus.submitting));
    final result = await _useCase.submitCode(event.code);

    if (result is ApiSuccess) {
      emit(state.copyWith(
        status: AttendanceStatus.submitSuccess,
        successMessage: 'Berhasil melakukan presensi perkuliahan.',
      ));
    } else if (result is ApiFailure) {
      final failure = result as ApiFailure;
      emit(state.copyWith(
        status: AttendanceStatus.failure,
        errorMessage: failure.message,
      ));
    }
  }
}
