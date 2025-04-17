import 'package:burningbros_test/features/products/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failure.dart';

class RemoveSaveFavoriteProductsUseCase {
  final ProductRepository repository;

  RemoveSaveFavoriteProductsUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.removeFavoriteProduct(id);
  }
}
