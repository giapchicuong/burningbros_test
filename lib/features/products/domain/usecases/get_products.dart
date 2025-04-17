import 'package:burningbros_test/features/products/data/models/product_pagination_query.dart';
import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:burningbros_test/features/products/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failure.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(
      ProductPaginationQueryModel query) async {
    return await repository.getProducts(query);
  }
}
