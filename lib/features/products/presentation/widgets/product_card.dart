import 'package:flutter/material.dart';

import '../../../../common/widgets/cached_image.dart';
import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.isFavorite = false,
    this.isShowFavorite = false,
    this.isShowRemoveFavorite = false,
  });

  final ProductEntity product;
  final bool isFavorite;
  final bool isShowFavorite;
  final bool isShowRemoveFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CachedImage(imageUrl: product.thumbnail),
        title: Text(product.title),
        subtitle: Text('Price: ${product.price}'),
        trailing: isShowRemoveFavorite
            ? Icon(Icons.remove_circle_outline_rounded)
            : isShowFavorite
                ? Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline_sharp,
                    color: isFavorite ? Colors.red : Colors.grey,
                  )
                : SizedBox.shrink(),
        onTap: onTap,
      ),
    );
  }
}
