import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:burningbros_test/features/products/domain/repository/product_repository.dart';
import 'package:burningbros_test/features/products/domain/usecases/get_save_favorite_products.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_save_products_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductRepository>()])
void main() {
  late GetSaveFavoriteProductsUseCase useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = GetSaveFavoriteProductsUseCase(mockProductRepository);
  });

  final tProductList = [
    ProductEntity(id: 1, title: 'title', price: 1000, thumbnail: ''),
    ProductEntity(id: 2, title: 'title', price: 1000, thumbnail: ''),
  ];

  test('should get all save products from the repository', () async {
    // arrange
    when(mockProductRepository.getFavoriteProducts())
        .thenAnswer((_) async => Right(tProductList));
    // act
    final result = await useCase();

    // assert
    expect(result, equals(Right(tProductList)));
    verify(mockProductRepository.getFavoriteProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });
}
