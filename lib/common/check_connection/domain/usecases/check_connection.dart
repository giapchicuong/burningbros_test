import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failure.dart';
import '../../../../core/network/network_infor.dart';

class CheckConnectionUseCase {
  final NetworkInfo networkInfo;

  CheckConnectionUseCase(this.networkInfo);

  Future<Either<Failure, bool>> call() async {
    final isConnected = await networkInfo.isConnected;
    return Right(isConnected);
  }
}
