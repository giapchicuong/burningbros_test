import 'package:burningbros_test/features/products/data/models/product.dart';
import 'package:hive/hive.dart';

class ProductsLocalService {
  final Box<ProductModel> productBox;

  ProductsLocalService(this.productBox);

  List<ProductModel> getFavoriteProducts() {
    return productBox.values.toList();
  }

  void saveFavoriteProduct(ProductModel product) {
    productBox.add(product);
  }

  void removeFavoriteProduct(int id) {
    final keyToDelete = productBox.keys.firstWhere(
      (key) => productBox.get(key)?.id == id,
      orElse: () => null,
    );

    if (keyToDelete != null) {
      productBox.delete(keyToDelete);
    }
  }
}
