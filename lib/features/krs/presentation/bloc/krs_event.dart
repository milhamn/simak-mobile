import 'package:equatable/equatable.dart';

abstract class KrsEvent extends Equatable {
  const KrsEvent();

  @override
  List<Object?> get props => [];
}

class KrsFetchRequested extends KrsEvent {}
