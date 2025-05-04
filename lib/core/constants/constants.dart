import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static final baseURL = dotenv.env['BASE_URL'];
  static final products = '$baseURL/products';
  static final searchProducts = '$products/search';
}
