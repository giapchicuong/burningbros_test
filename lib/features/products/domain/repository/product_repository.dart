import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
