part of 'check_connection_bloc.dart';

abstract class CheckConnectionState extends Equatable {
  const CheckConnectionState();

  @override
  List<Object> get props => [];
}

class CheckConnectionInitial extends CheckConnectionState {}

class CheckConnectionLoading extends CheckConnectionState {}

class CheckConnectionLoaded extends CheckConnectionState {}

class CheckConnectionFailure extends CheckConnectionState {}

class CheckConnectionError extends CheckConnectionState {}
