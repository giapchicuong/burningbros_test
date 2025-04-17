import 'package:burningbros_test/features/products/presentation/bloc/products/local/local_products_bloc.dart';
import 'package:burningbros_test/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/sizes.dart';
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
      separatorBuilder: (_, __) => const SizedBox(height: AppSizes.sm),
      itemBuilder: (context, index) {
        if (index < products.length) {
          final data = products[index];
          final bool isFavorite =
              productsFavorite.any((element) => element.id == data.id);
          return _buildProductCard(data, isFavorite, handleFavorite);
        } else {
          return hasReachedEnd
              ? const SizedBox.shrink()
              : _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildProductCard(ProductEntity product, bool isFavorite,
      void Function(ProductEntity, bool) onTap) {
    return RepaintBoundary(
      child: ProductCard(
        isShowFavorite: true,
        product: product,
        isFavorite: isFavorite,
        onTap: () => onTap(product, isFavorite),
      ),
    );
  }

  Widget _buildLoadingWidget() => Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.md),
        child: const Center(child: CircularProgressIndicator()),
      );
}
