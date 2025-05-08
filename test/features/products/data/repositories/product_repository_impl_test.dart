import 'package:burningbros_test/core/errors/server_exception.dart';
import 'package:burningbros_test/core/errors/server_failure.dart';
import 'package:burningbros_test/features/products/data/data_sources/local/products_local_service.dart';
import 'package:burningbros_test/features/products/data/data_sources/products_api_service.dart';
import 'package:burningbros_test/features/products/data/models/product.dart';
import 'package:burningbros_test/features/products/data/models/product_pagination_query.dart';
import 'package:burningbros_test/features/products/data/models/product_search_query.dart';
import 'package:burningbros_test/features/products/data/repository/product_repository_impl.dart';
import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_repository_impl_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<ProductsApiService>(), MockSpec<ProductsLocalService>()])
void main() {
  late MockProductsLocalService mockProductsLocalService;
  late MockProductsApiService mockProductsApiService;
  late ProductRepositoryImpl repository;

  setUp(() {
    mockProductsApiService = MockProductsApiService();
    mockProductsLocalService = MockProductsLocalService();
    repository = ProductRepositoryImpl(
      productsApiService: mockProductsApiService,
      productsLocalService: mockProductsLocalService,
    );
  });

  final tProductList = [
    ProductModel(id: 1, title: 'title', price: 1000, thumbnail: ''),
    ProductModel(id: 2, title: 'title', price: 1000, thumbnail: ''),
  ];
  final tProduct =
      ProductModel(id: 2, title: 'title', price: 1000, thumbnail: '');
  final tProductEntity =
      ProductEntity(id: 2, title: 'title', price: 1000, thumbnail: '');
  final tQuery = ProductPaginationQueryModel(limit: 20, skip: 0);
  final tSearch = ProductSearchQueryModel(query: 'bike', limit: 20, skip: 0);

  group('Remote: getProducts', () {
    test('should get all products from the remote data source', () async {
      // arrange
      when(mockProductsApiService.getProducts(tQuery))
          .thenAnswer((_) async => tProductList);
      // act
      final result = await repository.getProducts(tQuery);
      // assert
      verify(mockProductsApiService.getProducts(tQuery));
      expect(result, isA<Right<ServerFailure, List<ProductEntity>>>());
    });

    test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockProductsApiService.getProducts(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.getProducts(tQuery);
      // assert
      expect(result, isA<Left<ServerFailure, List<ProductEntity>>>());
    });
  });

  group('Remote: searchProducts', () {
    test('should search products from the remote data source', () async {
      // arrange
      when(mockProductsApiService.searchProducts(tSearch))
          .thenAnswer((_) async => tProductList);
      // act
      final result = await repository.searchProducts(tSearch);
      // assert
      verify(mockProductsApiService.searchProducts(tSearch));
      expect(result, isA<Right<ServerFailure, List<ProductEntity>>>());
    });

    test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockProductsApiService.searchProducts(tSearch))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchProducts(tSearch);
      // assert
      expect(result, isA<Left<Failure, List<ProductEntity>>>());
    });
  });

  group('Local: getFavoriteProducts', () {
    test('should get favorite products from the local data source', () async {
      // arrange
      when(mockProductsLocalService.getFavoriteProducts())
          .thenAnswer((_) async => tProductList);
      // act
      final result = await repository.getFavoriteProducts();
      // assert
      verify(mockProductsLocalService.getFavoriteProducts());
      expect(result, isA<Right<LocalFailure, List<ProductEntity>>>());
    });

    test(
        'should return LocalFailure when the call to local data source is unsuccessful',
        () async {
      // arrange
      when(mockProductsLocalService.getFavoriteProducts())
          .thenThrow(LocalException());
      // act
      final result = await repository.getFavoriteProducts();
      // assert
      expect(result, isA<Left<LocalFailure, List<ProductEntity>>>());
    });
  });

  group('Local: removeFavoriteProduct', () {
    test('should remote favorite products from the local data source',
        () async {
      // arrange
      when(mockProductsLocalService.removeFavoriteProduct(1))
          .thenAnswer((_) async => Future.value());
      // act
      final result = await repository.removeFavoriteProduct(1);
      // assert
      verify(mockProductsLocalService.removeFavoriteProduct(1));
      expect(result, isA<Right<LocalFailure, void>>());
    });

    test(
        'should return LocalFailure when the call to local data source is unsuccessful',
        () async {
      // arrange
      when(mockProductsLocalService.removeFavoriteProduct(1))
          .thenThrow(LocalException());
      // act
      final result = await repository.removeFavoriteProduct(1);
      // assert
      expect(result, isA<Left<LocalFailure, void>>());
    });
  });

  group('Local: saveFavoriteProduct', () {
    test('should save favorite product from the local data source', () async {
      // arrange
      when(mockProductsLocalService.saveFavoriteProduct(tProduct))
          .thenAnswer((_) async => Future.value());
      // act
      final result = await repository.saveFavoriteProduct(tProductEntity);
      // assert
      verify(mockProductsLocalService.saveFavoriteProduct(any));
      expect(result, isA<Right<LocalFailure, void>>());
    });
  });
}
