import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static String get baseURL =>
      dotenv.env['BASE_URL'] ?? 'https://dummyjson.com';
  static String get products => '$baseURL/products';
  static String get searchProducts => '$products/search';
}
