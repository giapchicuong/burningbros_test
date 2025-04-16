import 'package:burningbros_test/features/products/data/models/product.dart';

abstract class ProductsApiService {
  Future<List<ProductModel>> getProducts();
}
