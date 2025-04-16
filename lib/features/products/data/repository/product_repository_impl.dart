import 'package:burningbros_test/features/products/data/data_sources/products_api_service.dart';
import 'package:burningbros_test/features/products/data/models/product.dart';
import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failure.dart';
import '../../domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductsApiService productsApiService;

  ProductRepositoryImpl({required this.productsApiService});
  @override
  Future<Either<ServerFailure, List<ProductEntity>>> getProducts() async {
    try {
      final List<ProductModel> productModel =
          await productsApiService.getProducts();
      final List<ProductEntity> products =
          productModel.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
