import 'package:burningbros_test/core/constants/constants.dart';
import 'package:burningbros_test/core/errors/server_exception.dart';
import 'package:burningbros_test/core/network/dio_client.dart';
import 'package:burningbros_test/features/products/data/data_sources/products_api_service.dart';
import 'package:burningbros_test/features/products/data/data_sources/remote/products_api_service_impl.dart';
import 'package:burningbros_test/features/products/data/models/product_pagination_query.dart';
import 'package:burningbros_test/features/products/data/models/product_search_query.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_remote_data_source_test.mocks.dart';

@GenerateMocks([DioClient])
void main() {
  late ProductsApiService dataSource;
  late MockDioClient mockDioClient;

  late String tProductPaginationUrl;
  late String tSearchProductPaginationUrl;

  setUp(() async {
    await dotenv.load(fileName: ".env");
    mockDioClient = MockDioClient();
    dataSource = ProductsApiServiceImpl(client: mockDioClient);

    tProductPaginationUrl = ApiUrls.products;
    tSearchProductPaginationUrl = ApiUrls.searchProducts;
  });

  final tProductQuery = ProductPaginationQueryModel(limit: 20, skip: 0);
  final tSearchProductQuery =
      ProductSearchQueryModel(query: 'bike', limit: 20, skip: 0);
  final tQueryParams = tProductQuery.toJson();
  final tSearchQueryParams = tSearchProductQuery.toJson();

  final sampleApiResponse = {
    "products": [
      {
        "id": 1,
        "title": "Essence Mascara Lash Princess",
        "description":
            "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects.",
        "category": "beauty",
        "price": 9.99,
        "discountPercentage": 7.17,
        "rating": 4.94,
        "stock": 5,
        "tags": ["beauty", "mascara"],
        "brand": "Essence",
        "sku": "RCH45Q1A",
        "weight": 2,
        "dimensions": {"width": 23.17, "height": 14.43, "depth": 28.01},
        "warrantyInformation": "1 month warranty",
        "shippingInformation": "Ships in 1 month",
        "availabilityStatus": "Low Stock",
        "reviews": [],
        "returnPolicy": "30 days return policy",
        "minimumOrderQuantity": 24,
        "meta": {
          "createdAt": "2024-05-23T08:56:21.618Z",
          "updatedAt": "2024-05-23T08:56:21.618Z",
          "barcode": "9164035109868",
          "qrCode": "..."
        },
        "thumbnail": "...",
        "images": ["...", "...", "..."]
      }
    ]
  };

  test(
    'should perform a GET request on a url to get all products by query pagination',
    () async {
      //   arrange
      when(mockDioClient.get(tProductPaginationUrl,
              queryParameters: tQueryParams))
          .thenAnswer((_) async => Response(
              data: sampleApiResponse,
              statusCode: 200,
              requestOptions: RequestOptions()));

      //   act
      await dataSource.getProducts(tProductQuery);

      // assert
      verify(mockDioClient.get(tProductPaginationUrl,
          queryParameters: tQueryParams));
    },
  );

  test(
    'should perform a GET request on a url to get search products by query pagination',
    () async {
      //   arrange
      when(mockDioClient.get(tSearchProductPaginationUrl,
              queryParameters: tSearchQueryParams))
          .thenAnswer((_) async => Response(
              data: sampleApiResponse,
              statusCode: 200,
              requestOptions: RequestOptions()));

      //   act
      await dataSource.searchProducts(tSearchProductQuery);

      // assert
      verify(mockDioClient.get(tSearchProductPaginationUrl,
          queryParameters: tSearchQueryParams));
    },
  );

  test(
      'should throw a ServerException when the response code is 404 for getProducts',
      () async {
    // arrange
    when(mockDioClient.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response(
            data: 'Not Found',
            statusCode: 404,
            requestOptions: RequestOptions()));

    // act
    call() => dataSource.getProducts(tProductQuery);

    // assert
    expect(call, throwsA(isA<ServerException>()));
  });

  test(
      'should throw a ServerException when the response code is 404 for searchProducts',
      () async {
    // arrange
    when(mockDioClient.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response(
            data: 'Not Found',
            statusCode: 404,
            requestOptions: RequestOptions()));

    // act
    call() => dataSource.searchProducts(tSearchProductQuery);

    // assert
    expect(call, throwsA(isA<ServerException>()));
  });
}
