import 'package:burningbros_test/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/products/local/local_products_bloc.dart';

class ListViewProductFavorite extends StatelessWidget {
  const ListViewProductFavorite({
    super.key,
    required this.products,
  });

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LocalProductsBloc>();
    void handleRemove(ProductEntity productEntity) {
      bloc.add(RemoveSaveFavoriteProduct(id: productEntity.id));
    }

    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final data = products[index];
        return RepaintBoundary(
          child: ProductCard(
            product: data,
            isShowRemoveFavorite: true,
            onTap: () => handleRemove(data),
          ),
        );
      },
    );
  }
}
