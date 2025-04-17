import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../core/network/network_infor.dart';

class CheckConnectionRepositoryImpl implements NetworkInfo {
  final Connectivity connectivity;

  CheckConnectionRepositoryImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
