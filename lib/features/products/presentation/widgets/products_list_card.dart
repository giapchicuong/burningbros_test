import 'package:burningbros_test/features/products/presentation/bloc/products/local/local_products_bloc.dart';
import 'package:burningbros_test/features/products/presentation/widgets/list_view_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/products/remote/remote_products_bloc.dart';

class ProductsListCard extends StatelessWidget {
  const ProductsListCard({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final stateLocalProductsBloc = context.watch<LocalProductsBloc>().state;
    return Expanded(
        child: BlocBuilder<RemoteProductsBloc, RemoteProductsState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              var widgets = (switch (state) {
                RemoteProductsLoading() => _buildLoadingWidget(),
                RemoteProductsLoaded(
                  products: final products,
                  hasReachedEnd: final hasReachedEnd
                ) =>
                  products.isEmpty
                      ? _buildEmptyWidget()
                      : _buildInitialWidget(
                          products,
                          stateLocalProductsBloc is LocalProductsLoaded
                              ? stateLocalProductsBloc.products
                              : [],
                          hasReachedEnd),
                RemoteProductsError(message: final msg) =>
                  _buildErrorWidget(msg),
                _ => Container(),
              });
              return widgets;
            }));
  }

  Widget _buildInitialWidget(List<ProductEntity> products,
      List<ProductEntity> productsFavorite, bool hasReachedEnd) {
    return ListViewProduct(
      scrollController: scrollController,
      productsFavorite: productsFavorite,
      products: products,
      hasReachedEnd: hasReachedEnd,
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
