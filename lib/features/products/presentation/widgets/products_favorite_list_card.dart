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
        builder: (context, state) {
          var widgets = (switch (state) {
            LocalProductsLoading() => _buildLoadingWidget(),
            LocalProductsLoaded(
              products: final products,
            ) =>
              products.isEmpty
                  ? _buildEmptyWidget()
                  : _buildInitialWidget(products),
            LocalProductsError(message: final msg) => _buildErrorWidget(msg),
            _ => Container(),
          });
          return widgets;
        });
  }

  Widget _buildInitialWidget(List<ProductEntity> products) {
    return ListViewProductFavorite(
      products: products,
    );
  }

  Widget _buildEmptyWidget() {
    return const Center(child: Text('No products available.'));
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildLoadingWidget() =>
      const Center(child: CircularProgressIndicator());
}
