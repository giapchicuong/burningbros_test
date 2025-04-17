import 'package:burningbros_test/features/products/presentation/bloc/products/local/local_products_bloc.dart';
import 'package:burningbros_test/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'features/products/data/models/product.dart';
import 'features/products/presentation/bloc/products/remote/remote_products_bloc.dart';
import 'features/products/presentation/pages/products_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(ProductModelAdapter());
  final productBox = await Hive.openBox<ProductModel>('products');
  setupServiceLocator(productBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burning Bros',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl<RemoteProductsBloc>()..add(FetchProducts(isLoading: true)),
          ),
          BlocProvider<LocalProductsBloc>.value(
            value: sl<LocalProductsBloc>()..add(GetSaveFavoriteProducts()),
          ),
        ],
        child: const ProductsScreen(),
      ),
    );
  }
}
