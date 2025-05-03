import 'package:burningbros_test/features/products/domain/usecases/remove_save_favorite_products.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_save_products_test.mocks.dart';

void main() {
  late RemoveSaveFavoriteProductsUseCase useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = RemoveSaveFavoriteProductsUseCase(mockProductRepository);
  });

  final tProductId = 1;
  test('should remove save product to favorite via repository', () async {
    // arrange
    when(mockProductRepository.removeFavoriteProduct(tProductId))
        .thenAnswer((_) async => Right(null));
    // act
    final result = await useCase(tProductId);
    // assert
    expect(result, equals(Right(null)));
    verify(mockProductRepository.removeFavoriteProduct(tProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
