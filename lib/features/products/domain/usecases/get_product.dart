import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:burningbros_test/features/products/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failure.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.getProducts();
  }
}
