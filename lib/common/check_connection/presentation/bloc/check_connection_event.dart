part of 'check_connection_bloc.dart';

abstract class CheckConnectionEvent extends Equatable {
  const CheckConnectionEvent();

  @override
  List<Object?> get props => [];
}

class CheckConnectionStart extends CheckConnectionEvent {}

class CheckConnectionChanged extends CheckConnectionEvent {
  final ConnectivityResult result;

  const CheckConnectionChanged(this.result);

  @override
  List<Object?> get props => [result];
}
