import 'package:equatable/equatable.dart';
import 'package:simak_mobile/features/portal/domain/entities/portal_info_entity.dart';

enum PortalStatus { initial, loading, success, failure }

class PortalState extends Equatable {
  final PortalStatus status;
  final PortalInfoEntity? portalInfo;
  final String? errorMessage;

  const PortalState({
    this.status = PortalStatus.initial,
    this.portalInfo,
    this.errorMessage,
  });

  PortalState copyWith({
    PortalStatus? status,
    PortalInfoEntity? portalInfo,
    String? errorMessage,
  }) {
    return PortalState(
      status: status ?? this.status,
      portalInfo: portalInfo ?? this.portalInfo,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, portalInfo, errorMessage];
}
