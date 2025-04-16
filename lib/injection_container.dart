import 'package:burningbros_test/features/products/data/data_sources/products_api_service.dart';
import 'package:burningbros_test/features/products/data/data_sources/remote/products_api_service_impl.dart';
import 'package:burningbros_test/features/products/data/repository/product_repository_impl.dart';
import 'package:burningbros_test/features/products/domain/repository/product_repository.dart';
import 'package:burningbros_test/features/products/domain/usecases/get_product.dart';
import 'package:burningbros_test/features/products/presentation/bloc/product/remote/products/products_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Bloc
  sl.registerFactory(() => ProductsBloc(getProducts: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetProducts(sl()));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productsApiService: sl()));

  // Services
  sl.registerLazySingleton<ProductsApiService>(
      () => ProductsApiServiceImpl(client: sl()));

  // Dio Service
  sl.registerSingleton<DioClient>(DioClient());
}
