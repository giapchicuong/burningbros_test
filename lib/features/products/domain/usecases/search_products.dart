import 'package:burningbros_test/features/products/data/models/product_search_query.dart';
import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:burningbros_test/features/products/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failure.dart';

class SearchProducts {
  final ProductRepository repository;

  SearchProducts(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(
      ProductSearchQueryModel query) async {
    return await repository.searchProducts(query);
  }
}
