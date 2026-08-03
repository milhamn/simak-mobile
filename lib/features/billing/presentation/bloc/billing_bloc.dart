import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/features/billing/domain/usecases/get_billing_usecase.dart';
import 'package:simak_mobile/features/billing/presentation/bloc/billing_event.dart';
import 'package:simak_mobile/features/billing/presentation/bloc/billing_state.dart';

class BillingBloc extends Bloc<BillingEvent, BillingState> {
  final GetBillingUseCase _useCase;

  BillingBloc({required GetBillingUseCase useCase})
      : _useCase = useCase,
        super(const BillingState()) {
    on<BillingFetchRequested>(_onBillingFetchRequested);
  }

  Future<void> _onBillingFetchRequested(
    BillingFetchRequested event,
    Emitter<BillingState> emit,
  ) async {
    emit(state.copyWith(status: BillingStatus.loading));
    final result = await _useCase.execute();

    if (result is ApiSuccess) {
      final success = result as ApiSuccess;
      emit(state.copyWith(
        status: BillingStatus.success,
        billings: success.data,
      ));
    } else {
      emit(state.copyWith(
        status: BillingStatus.failure,
        errorMessage: 'Gagal memuat informasi tagihan.',
      ));
    }
  }
}
