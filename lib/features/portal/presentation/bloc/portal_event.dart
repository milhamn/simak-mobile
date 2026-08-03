import 'package:equatable/equatable.dart';

abstract class PortalEvent extends Equatable {
  const PortalEvent();

  @override
  List<Object?> get props => [];
}

class PortalFetchRequested extends PortalEvent {}
