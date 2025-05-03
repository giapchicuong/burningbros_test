import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:burningbros_test/features/products/domain/usecases/save_favorite_products.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_save_products_test.mocks.dart';

void main() {
  late SaveFavoriteProductsUseCase useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = SaveFavoriteProductsUseCase(mockProductRepository);
  });

  final tSaveProduct = ProductEntity(
      id: 1, title: 'title', price: 1000, thumbnail: ' thumbnail');

  test('should save product to favorite via repository', () async {
    // arrange
    when(mockProductRepository.saveFavoriteProduct(tSaveProduct))
        .thenAnswer((_) async => Right(null));
    // act
    final result = await useCase(tSaveProduct);
    // assert
    expect(result, equals(Right(null)));
    verify(mockProductRepository.saveFavoriteProduct(tSaveProduct));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
