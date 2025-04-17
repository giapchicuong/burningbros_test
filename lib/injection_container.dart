import 'package:burningbros_test/common/check_connection/domain/usecases/check_connection.dart';
import 'package:burningbros_test/common/check_connection/presentation/bloc/check_connection_bloc.dart';
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
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'common/check_connection/data/repository/check_connection_repository_impl.dart';
import 'core/network/dio_client.dart';
import 'core/network/network_infor.dart';
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
  sl.registerFactory(() => CheckConnectionBloc(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => SearchProducts(sl()));
  sl.registerLazySingleton(() => GetSaveFavoriteProductsUseCase(sl()));
  sl.registerLazySingleton(() => RemoveSaveFavoriteProductsUseCase(sl()));
  sl.registerLazySingleton(() => SaveFavoriteProductsUseCase(sl()));
  sl.registerLazySingleton(() => CheckConnectionUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      productsApiService: sl(), productsLocalService: sl()));
  sl.registerLazySingleton<NetworkInfo>(
      () => CheckConnectionRepositoryImpl(sl()));

  // Services
  sl.registerLazySingleton<ProductsApiService>(
      () => ProductsApiServiceImpl(client: sl()));
  sl.registerLazySingleton<ProductsLocalService>(
      () => ProductsLocalService(productBox));

  // Dio Service
  sl.registerSingleton<DioClient>(DioClient());

  // Check Connect
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
}
