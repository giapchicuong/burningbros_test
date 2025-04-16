import 'package:burningbros_test/features/products/data/data_sources/products_api_service.dart';
import 'package:burningbros_test/features/products/data/models/product.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/server_exception.dart';
import '../../../../../core/network/dio_client.dart';

class ProductsApiServiceImpl extends ProductsApiService {
  final DioClient client;

  ProductsApiServiceImpl({required this.client});
  @override
  Future<List<ProductModel>> getProducts() async {
    var response = await client.get(ApiUrls.products);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['products'];
      print(">>> $data");
      final List<ProductModel> products = data
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return products;
    } else {
      throw ServerException();
    }
  }
}
