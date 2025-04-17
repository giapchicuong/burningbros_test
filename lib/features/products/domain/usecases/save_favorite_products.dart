import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:burningbros_test/features/products/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failure.dart';

class SaveFavoriteProductsUseCase {
  final ProductRepository repository;

  SaveFavoriteProductsUseCase(this.repository);

  Future<Either<Failure, void>> call(ProductEntity product) async {
    return await repository.saveFavoriteProduct(product);
  }
}
