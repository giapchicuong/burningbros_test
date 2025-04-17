import 'package:burningbros_test/features/products/presentation/widgets/products_favorite_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/products/local/local_products_bloc.dart';

class ProductsFavoriteScreen extends StatelessWidget {
  const ProductsFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalProductsBloc>.value(
      value: sl<LocalProductsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Products'),
          backgroundColor: Colors.grey.withOpacity(0.2),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ProductsFavoriteListCard(),
        ),
      ),
    );
  }
}
