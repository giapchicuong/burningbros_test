import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:burningbros_test/common/check_connection/domain/usecases/check_connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'check_connection_event.dart';
part 'check_connection_state.dart';

class CheckConnectionBloc
    extends Bloc<CheckConnectionEvent, CheckConnectionState> {
  final CheckConnectionUseCase checkConnectionUseCase;
  late final StreamSubscription _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  CheckConnectionBloc(this.checkConnectionUseCase)
      : super(CheckConnectionInitial()) {
    on<CheckConnectionStart>(_onCheckConnectionStart);
    on<CheckConnectionChanged>(_onCheckConnectionChanged);

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      add(CheckConnectionChanged(result));
    });
  }

  Future<void> _onCheckConnectionStart(
    CheckConnectionStart event,
    Emitter<CheckConnectionState> emit,
  ) async {
    emit(CheckConnectionLoading());

    final result = await checkConnectionUseCase();

    result.fold(
      (_) => emit(CheckConnectionError()),
      (isConnected) => emit(
        isConnected ? CheckConnectionLoaded() : CheckConnectionFailure(),
      ),
    );
  }

  void _onCheckConnectionChanged(
    CheckConnectionChanged event,
    Emitter<CheckConnectionState> emit,
  ) {
    if (event.result == ConnectivityResult.none) {
      emit(CheckConnectionFailure());
    } else {
      emit(CheckConnectionLoaded());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();

    return super.close();
  }
}
