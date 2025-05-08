import 'package:burningbros_test/features/products/data/data_sources/local/products_local_service.dart';
import 'package:burningbros_test/features/products/data/data_sources/products_api_service.dart';
import 'package:burningbros_test/features/products/data/models/product.dart';
import 'package:burningbros_test/features/products/data/models/product_search_query.dart';
import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failure.dart';
import '../../domain/repository/product_repository.dart';
import '../models/product_pagination_query.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductsApiService productsApiService;
  final ProductsLocalService productsLocalService;

  ProductRepositoryImpl(
      {required this.productsApiService, required this.productsLocalService});

  @override
  Future<Either<ServerFailure, List<ProductEntity>>> getProducts(
      ProductPaginationQueryModel productQuery) async {
    try {
      final List<ProductModel> productModel =
          await productsApiService.getProducts(productQuery);
      final List<ProductEntity> products =
          productModel.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, List<ProductEntity>>> searchProducts(
      ProductSearchQueryModel productSearchQuery) async {
    try {
      final List<ProductModel> productModel =
          await productsApiService.searchProducts(productSearchQuery);
      final List<ProductEntity> products =
          productModel.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<LocalFailure, List<ProductEntity>>>
      getFavoriteProducts() async {
    try {
      final productModel = await productsLocalService.getFavoriteProducts();
      final List<ProductEntity> products =
          productModel.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<LocalFailure, void>> removeFavoriteProduct(int id) async {
    try {
      await productsLocalService.removeFavoriteProduct(id);
      return Right(null);
    } catch (e) {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<LocalFailure, void>> saveFavoriteProduct(
      ProductEntity product) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      productsLocalService.saveFavoriteProduct(productModel);
      return Right(null);
    } catch (e) {
      return Left(LocalFailure());
    }
  }
}
