import 'package:burningbros_test/features/products/data/data_sources/local/products_local_service.dart';
import 'package:burningbros_test/features/products/data/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_local_data_source_test.mocks.dart';

@GenerateMocks([Box<ProductModel>])
void main() {
  late MockBox<ProductModel> mockBox;
  late ProductsLocalService dataSource;

  setUp(() {
    mockBox = MockBox();
    dataSource = ProductsLocalService(mockBox);
  });
  final tProductList = [
    ProductModel(id: 1, title: 'title', price: 1000, thumbnail: ''),
    ProductModel(id: 2, title: 'title', price: 1000, thumbnail: ''),
  ];
  final tProduct =
      ProductModel(id: 1, title: 'title', price: 1000, thumbnail: '');
  test(
    'should return favorite products when getFavoriteProducts is called',
    () async {
      //   arrange
      when(mockBox.values).thenAnswer((_) => tProductList);
      //   act
      final result = dataSource.getFavoriteProducts();
      //   assert
      expect(result, tProductList);
      verify(mockBox.values).called(1);
    },
  );

  test(
    'should save a product when saveFavoriteProduct is called',
    () async {
      //   arrange
      when(mockBox.add(any)).thenAnswer((_) async => 0);
      //   act
      dataSource.saveFavoriteProduct(tProduct);
      //   assert
      verify(mockBox.add(tProduct)).called(1);
    },
  );
  test(
    'should delete a product by id when removeFavoriteProduct is called',
    () {
      // Arrange
      when(mockBox.keys).thenReturn([0, 1, 2, 3]);
      when(mockBox.get(0)).thenReturn(tProduct);
      when(mockBox.get(1)).thenReturn(
          ProductModel(id: 2, title: 'title', price: 1000, thumbnail: ''));
      when(mockBox.get(2)).thenReturn(
          ProductModel(id: 3, title: 'title', price: 1000, thumbnail: ''));

      // Act
      dataSource.removeFavoriteProduct(1);

      // Assert
      verify(mockBox.delete(0)).called(1);
    },
  );

  test(
    'should not delete anything if product with id is not found',
    () {
      // Arrange
      when(mockBox.keys).thenReturn([0]);
      when(mockBox.get(0)).thenReturn(tProduct);

      // Act
      dataSource.removeFavoriteProduct(999);

      // Assert
      verifyNever(mockBox.delete(any));
    },
  );
}
