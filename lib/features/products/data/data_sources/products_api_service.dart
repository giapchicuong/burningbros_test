import 'package:burningbros_test/features/products/data/models/product.dart';

import '../models/product_pagination_query.dart';
import '../models/product_search_query.dart';

abstract class ProductsApiService {
  Future<List<ProductModel>> getProducts(
      ProductPaginationQueryModel productQuery);
  Future<List<ProductModel>> searchProducts(
      ProductSearchQueryModel productSearchQuery);
}
