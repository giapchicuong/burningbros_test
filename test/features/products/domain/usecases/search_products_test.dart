import 'package:burningbros_test/features/products/data/models/product_search_query.dart';
import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:burningbros_test/features/products/domain/usecases/search_products.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_save_products_test.mocks.dart';

void main() {
  late SearchProducts useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = SearchProducts(mockProductRepository);
  });

  final tProductList = [
    ProductEntity(id: 1, title: 'title', price: 1000, thumbnail: ''),
    ProductEntity(id: 2, title: 'title', price: 1000, thumbnail: ''),
  ];
  final tQuery = ProductSearchQueryModel(query: 'Bike', limit: 20, skip: 20);

  test('should get products from the query from the repository', () async {
    // arrange
    when(mockProductRepository.searchProducts(tQuery))
        .thenAnswer((_) async => Right(tProductList));
    // act
    final result = await useCase(tQuery);
    // assert
    expect(result, equals(Right(tProductList)));
    verify(mockProductRepository.searchProducts(tQuery));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
