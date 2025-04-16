import 'package:burningbros_test/features/products/presentation/bloc/product/remote/products/products_bloc.dart';
import 'package:burningbros_test/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/products/presentation/pages/products_screen.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burning Bros',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<ProductsBloc>()..add(FetchProducts()),
          ),
        ],
        child: const ProductsScreen(),
      ),
    );
  }
}
