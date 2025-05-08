import 'package:burningbros_test/features/products/data/models/product.dart';
import 'package:hive/hive.dart';

import '../../../../../core/errors/server_exception.dart';

class ProductsLocalService {
  final Box<ProductModel> productBox;

  ProductsLocalService(this.productBox);

  Future<List<ProductModel>> getFavoriteProducts() async {
    try {
      return productBox.values.toList();
    } catch (e) {
      throw LocalException();
    }
  }

  Future<void> saveFavoriteProduct(ProductModel product) async {
    try {
      await productBox.add(product);
    } catch (e) {
      throw LocalException();
    }
  }

  Future<void> removeFavoriteProduct(int id) async {
    try {
      final keyToDelete = productBox.keys.firstWhere(
        (key) => productBox.get(key)?.id == id,
        orElse: () => null,
      );

      if (keyToDelete != null) {
        await productBox.delete(keyToDelete);
      } else {
        throw LocalException();
      }
    } catch (e) {
      throw LocalException();
    }
  }
}
