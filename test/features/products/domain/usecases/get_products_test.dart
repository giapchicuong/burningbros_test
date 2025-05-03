import 'package:burningbros_test/features/products/data/models/product_pagination_query.dart';
import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:burningbros_test/features/products/domain/usecases/get_products.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_save_products_test.mocks.dart';

void main() {
  late GetProducts useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = GetProducts(mockProductRepository);
  });

  final tProductList = [
    ProductEntity(id: 1, title: 'title', price: 1000, thumbnail: ''),
    ProductEntity(id: 2, title: 'title', price: 1000, thumbnail: ''),
  ];
  final tQuery = ProductPaginationQueryModel(limit: 20, skip: 0);

  test('should get all products with pagination from the repository', () async {
    // arrange
    when(mockProductRepository.getProducts(tQuery))
        .thenAnswer((_) async => Right(tProductList));
    // act
    final result = await useCase(tQuery);
    // assert
    expect(result, equals(Right(tProductList)));
    verify(mockProductRepository.getProducts(tQuery));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
