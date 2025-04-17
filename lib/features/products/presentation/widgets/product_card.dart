import 'package:burningbros_test/core/constants/text_strings.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/cached_image.dart';
import '../../../../core/constants/sizes.dart';
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
        borderRadius: BorderRadius.circular(AppSizes.radiusBase),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSizes.base),
        leading: CachedImage(imageUrl: product.thumbnail),
        title: Text(product.title),
        subtitle: Text('${AppTexts.price}: ${product.price}'),
        trailing: _buildTrailing(),
        onTap: onTap,
      ),
    );
  }

  Widget _buildTrailing() {
    if (isShowRemoveFavorite) {
      return Icon(Icons.remove_circle_outline_rounded);
    } else if (isShowFavorite) {
      return Icon(
        isFavorite ? Icons.favorite : Icons.favorite_outline_sharp,
        color: isFavorite ? Colors.red : Colors.grey,
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
