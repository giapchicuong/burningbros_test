import 'package:burningbros_test/core/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/products/local/local_products_bloc.dart';
import 'list_view_products_favorite.dart';

class ProductsFavoriteListCard extends StatelessWidget {
  const ProductsFavoriteListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalProductsBloc, LocalProductsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => switch (state) {
        LocalProductsLoading() => _buildLoadingWidget(),
        LocalProductsError(message: final msg) => _buildErrorWidget(msg),
        LocalProductsLoaded(products: final products) => products.isEmpty
            ? _buildEmptyWidget()
            : _buildInitialWidget(products),
        _ => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildInitialWidget(List<ProductEntity> products) {
    return ListViewProductFavorite(products: products);
  }

  Widget _buildEmptyWidget() {
    return const Center(child: Text(AppTexts.noProductsAvailable));
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }
}
