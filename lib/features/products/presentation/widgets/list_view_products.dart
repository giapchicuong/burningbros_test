import 'package:burningbros_test/features/products/presentation/bloc/products/local/local_products_bloc.dart';
import 'package:burningbros_test/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';

class ListViewProduct extends StatelessWidget {
  const ListViewProduct(
      {super.key,
      required this.scrollController,
      required this.products,
      required this.hasReachedEnd,
      required this.productsFavorite});

  final ScrollController scrollController;
  final List<ProductEntity> products;
  final List<ProductEntity> productsFavorite;
  final bool hasReachedEnd;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LocalProductsBloc>();
    void handleFavorite(ProductEntity productEntity, bool isFavorite) {
      if (isFavorite) {
        bloc.add(RemoveSaveFavoriteProduct(id: productEntity.id));
      } else {
        bloc.add(SaveFavoriteProduct(productEntity: productEntity));
      }
    }

    return ListView.separated(
      controller: scrollController,
      itemCount: products.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index < products.length) {
          final data = products[index];
          final bool isFavorite =
              productsFavorite.any((element) => element.id == data.id);
          return RepaintBoundary(
              child: ProductCard(
            isShowFavorite: true,
            product: data,
            isFavorite: isFavorite,
            onTap: () => handleFavorite(data, isFavorite),
          ));
        } else {
          return hasReachedEnd
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: _buildLoadingWidget(),
                );
        }
      },
    );
  }

  Widget _buildLoadingWidget() =>
      const Center(child: CircularProgressIndicator());
}
