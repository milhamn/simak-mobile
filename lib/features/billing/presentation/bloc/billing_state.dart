import 'package:equatable/equatable.dart';
import 'package:simak_mobile/features/billing/domain/entities/billing_item_entity.dart';

enum BillingStatus { initial, loading, success, failure }

class BillingState extends Equatable {
  final BillingStatus status;
  final List<BillingItemEntity> billings;
  final String? errorMessage;

  const BillingState({
    this.status = BillingStatus.initial,
    this.billings = const [],
    this.errorMessage,
  });

  BillingState copyWith({
    BillingStatus? status,
    List<BillingItemEntity>? billings,
    String? errorMessage,
  }) {
    return BillingState(
      status: status ?? this.status,
      billings: billings ?? this.billings,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, billings, errorMessage];
}
