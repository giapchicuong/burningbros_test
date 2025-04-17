import 'package:burningbros_test/features/products/data/models/product_search_query.dart';
import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failure.dart';
import '../../data/models/product_pagination_query.dart';

abstract class ProductRepository {
  // Api Method
  Future<Either<Failure, List<ProductEntity>>> getProducts(
      ProductPaginationQueryModel productQuery);
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
      ProductSearchQueryModel productSearchQuery);

  // Database Method
  Future<Either<Failure, List<ProductEntity>>> getFavoriteProducts();
  Future<Either<Failure, void>> saveFavoriteProduct(ProductEntity product);
  Future<Either<Failure, void>> removeFavoriteProduct(int id);
}
