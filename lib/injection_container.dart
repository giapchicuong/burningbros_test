import 'package:burningbros_test/features/products/data/data_sources/local/products_local_service.dart';
import 'package:burningbros_test/features/products/data/data_sources/products_api_service.dart';
import 'package:burningbros_test/features/products/data/data_sources/remote/products_api_service_impl.dart';
import 'package:burningbros_test/features/products/data/repository/product_repository_impl.dart';
import 'package:burningbros_test/features/products/domain/repository/product_repository.dart';
import 'package:burningbros_test/features/products/domain/usecases/get_products.dart';
import 'package:burningbros_test/features/products/domain/usecases/get_save_favorite_products.dart';
import 'package:burningbros_test/features/products/domain/usecases/remove_save_favorite_products.dart';
import 'package:burningbros_test/features/products/domain/usecases/save_favorite_products.dart';
import 'package:burningbros_test/features/products/domain/usecases/search_products.dart';
import 'package:burningbros_test/features/products/presentation/bloc/products/local/local_products_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'core/network/dio_client.dart';
import 'features/products/data/models/product.dart';
import 'features/products/presentation/bloc/products/remote/remote_products_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator(Box<ProductModel> productBox) {
  // Bloc
  sl.registerFactory(
      () => RemoteProductsBloc(getProducts: sl(), searchProducts: sl()));
  sl.registerLazySingleton(() => LocalProductsBloc(
        saveFavoriteProductsUseCase: sl(),
        removeSaveFavoriteProduct: sl(),
        getSaveFavoriteProductsUseCase: sl(),
      ));

  // Usecases
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => SearchProducts(sl()));
  sl.registerLazySingleton(() => GetSaveFavoriteProductsUseCase(sl()));
  sl.registerLazySingleton(() => RemoveSaveFavoriteProductsUseCase(sl()));
  sl.registerLazySingleton(() => SaveFavoriteProductsUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      productsApiService: sl(), productsLocalService: sl()));

  // Services
  sl.registerLazySingleton<ProductsApiService>(
      () => ProductsApiServiceImpl(client: sl()));
  sl.registerLazySingleton<ProductsLocalService>(
      () => ProductsLocalService(productBox));

  // Dio Service
  sl.registerSingleton<DioClient>(DioClient());
}
